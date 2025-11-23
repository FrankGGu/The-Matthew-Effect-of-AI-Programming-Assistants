pub fn minimum_travel_time(positions: Vec<i32>, start: i32, end: i32) -> i32 {
    let mut travel_times = vec![i32::MAX; positions.len()];
    travel_times[start as usize] = 0;
    let mut queue = std::collections::VecDeque::new();
    queue.push_back(start);

    while let Some(pos) = queue.pop_front() {
        let time = travel_times[pos as usize];
        for &next_pos in positions.iter() {
            let next_time = time + (next_pos - pos).abs();
            if next_time < travel_times[next_pos as usize] {
                travel_times[next_pos as usize] = next_time;
                queue.push_back(next_pos);
            }
        }
    }

    travel_times[end as usize]
}