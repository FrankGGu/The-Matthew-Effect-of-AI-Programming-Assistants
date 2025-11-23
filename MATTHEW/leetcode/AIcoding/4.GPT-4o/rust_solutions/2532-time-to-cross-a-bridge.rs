pub fn find_crossing_time(n: i32, k: i32, time: Vec<Vec<i32>>) -> i32 {
    let mut left = 0;
    let mut right = 0;
    let mut time_on_bridge = 0;
    let mut on_bridge = 0;
    let mut queue: Vec<(i32, i32)> = time.iter().enumerate().map(|(i, t)| (t[0], i as i32)).collect();
    queue.sort();

    let mut waiting: Vec<(i32, i32)> = Vec::new();
    while on_bridge < n {
        while let Some(&(t, idx)) = queue.first() {
            if t <= time_on_bridge {
                waiting.push(queue.remove(0));
            } else {
                break;
            }
        }

        if on_bridge < k && !waiting.is_empty() {
            let (t, idx) = waiting.remove(0);
            time_on_bridge += time[idx as usize][1];
            on_bridge += 1;
        }

        if on_bridge > 0 {
            time_on_bridge += 1;
            if time_on_bridge % 2 == 0 {
                on_bridge -= 1;
            }
        } else {
            time_on_bridge += 1;
        }
    }

    time_on_bridge
}