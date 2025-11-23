use std::cmp::Reverse;
use std::collections::BinaryHeap;

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct Worker {
    left_to_right: i32,
    pick_old: i32,
    right_to_left: i32,
    put_new: i32,
    index: usize,
}

impl Worker {
    fn new(lr: i32, po: i32, rl: i32, pn: i32, i: usize) -> Self {
        Worker {
            left_to_right: lr,
            pick_old: po,
            right_to_left: rl,
            put_new: pn,
            index: i,
        }
    }
}

pub fn find_crossing_time(n: i32, k: i32, time: Vec<Vec<i32>>) -> i32 {
    let n = n as usize;
    let k = k as usize;
    let mut workers = Vec::with_capacity(k);
    for i in 0..k {
        let t = &time[i];
        workers.push(Worker::new(t[0], t[1], t[2], t[3], i));
    }

    let mut left_waiting = BinaryHeap::new();
    let mut right_waiting = BinaryHeap::new();
    let mut left_working = BinaryHeap::new();
    let mut right_working = BinaryHeap::new();

    for i in 0..k {
        left_waiting.push(workers[i]);
    }

    let mut current_time = 0;
    let mut remaining_boxes = n;
    let mut left_warehouse = n;
    let mut right_warehouse = 0;

    while remaining_boxes > 0 || right_warehouse > 0 || !right_waiting.is_empty() || !right_working.is_empty() {
        while let Some((t, worker)) = left_working.peek().cloned() {
            if -t > current_time {
                break;
            }
            left_working.pop();
            left_waiting.push(worker);
        }
        while let Some((t, worker)) = right_working.peek().cloned() {
            if -t > current_time {
                break;
            }
            right_working.pop();
            right_waiting.push(worker);
        }

        if !right_waiting.is_empty() {
            let worker = right_waiting.pop().unwrap();
            current_time += worker.right_to_left;
            left_working.push((Reverse(current_time + worker.put_new), worker));
            right_warehouse -= 1;
        } else if !left_waiting.is_empty() && remaining_boxes > 0 {
            let worker = left_waiting.pop().unwrap();
            current_time += worker.left_to_right;
            right_working.push((Reverse(current_time + worker.pick_old), worker));
            remaining_boxes -= 1;
            left_warehouse -= 1;
            right_warehouse += 1;
        } else {
            let next_time = left_working
                .peek()
                .map(|&(t, _)| t.0)
                .unwrap_or(i32::MAX)
                .min(
                    right_working
                        .peek()
                        .map(|&(t, _)| t.0)
                        .unwrap_or(i32::MAX),
                );
            if next_time == i32::MAX {
                break;
            }
            current_time = next_time;
        }
    }

    current_time
}