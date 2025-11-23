use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn time_to_cross(num_workers: i32, bridge_time: Vec<Vec<i32>>, p: Vec<i32>) -> i32 {
        let n = num_workers as usize;
        let mut workers: Vec<(i32, i32)> = p.into_iter().zip(0..n as i32).collect();
        workers.sort_by_key(|&(x, _)| x);
        workers.reverse();

        let mut left_wait: BinaryHeap<(i32, i32)> = BinaryHeap::new();
        for i in 0..n {
            left_wait.push((workers[i].0, workers[i].1));
        }

        let mut right_wait: BinaryHeap<(i32, i32)> = BinaryHeap::new();
        let mut left_available: Vec<i32> = vec![0; n];
        let mut right_available: Vec<i32> = vec![0; n];
        let mut time: i32 = 0;
        let mut left_workers: i32 = num_workers;
        let mut right_workers: i32 = 0;
        let m = bridge_time.len();

        while right_workers < m as i32 {
            while !right_wait.is_empty() && right_available[right_wait.peek().unwrap().1 as usize] <= time {
                let (skill, id) = right_wait.pop().unwrap();
                left_wait.push((skill, id));
                right_workers -= 1;
                left_workers += 1;
            }

            while !left_wait.is_empty() && left_available[left_wait.peek().unwrap().1 as usize] <= time {
                let (skill, id) = left_wait.pop().unwrap();
                right_wait.push((skill, id));
                left_workers -= 1;
                right_workers += 1;
            }

            if right_wait.is_empty() && left_wait.is_empty() {
                let mut next_time = i32::MAX;
                for i in 0..n {
                    next_time = next_time.min(left_available[i].min(right_available[i]));
                }
                time = next_time;
                continue;
            }

            if right_wait.is_empty() {
                let (_, id) = left_wait.pop().unwrap();
                left_workers -= 1;
                right_workers += 1;
                time += bridge_time[0][0] + workers.iter().find(|(_, worker_id)| *worker_id == id).unwrap().0;
                right_available[id as usize] = time + bridge_time[0][1];
                right_wait.push((workers.iter().find(|(_, worker_id)| *worker_id == id).unwrap().0, id));
            } else {
                let (_, id) = right_wait.pop().unwrap();
                right_workers -= 1;
                left_workers += 1;
                time += bridge_time[0][2] + workers.iter().find(|(_, worker_id)| *worker_id == id).unwrap().0;
                left_available[id as usize] = time + bridge_time[0][3];
                left_wait.push((workers.iter().find(|(_, worker_id)| *worker_id == id).unwrap().0, id));
            }
        }

        time
    }
}