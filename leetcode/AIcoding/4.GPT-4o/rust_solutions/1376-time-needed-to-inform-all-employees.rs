use std::collections::VecDeque;

pub fn num_of_minutes(n: i32, head_id: i32, manager: Vec<i32>, inform_time: Vec<i32>) -> i32 {
    let mut subordinates = vec![vec![]; n as usize];
    for (i, &m) in manager.iter().enumerate() {
        if m != -1 {
            subordinates[m as usize].push(i as i32);
        }
    }

    let mut max_time = 0;
    let mut queue = VecDeque::new();
    queue.push_back((head_id, 0));

    while let Some((id, time)) = queue.pop_front() {
        max_time = max_time.max(time);
        for &sub in &subordinates[id as usize] {
            queue.push_back((sub, time + inform_time[id as usize]));
        }
    }

    max_time
}