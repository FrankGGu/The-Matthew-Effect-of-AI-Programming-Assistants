impl Solution {
    pub fn find_minimum_time(time: Vec<Vec<i32>>, capacity: i32) -> i64 {
        let n = time.len();
        let mut time = time;
        time.sort_by_key(|x| x[0]);

        let mut pq = std::collections::BinaryHeap::new();
        let mut arrival = vec![0; n];

        let mut current_time = 0;
        let mut available_workers = 0;

        for i in 0..n {
            while !pq.is_empty() && -pq.peek().unwrap() <= current_time {
                available_workers += 1;
                pq.pop();
            }

            let room_idx = time[i][0] as usize;

            if available_workers > 0 {
                available_workers -= 1;
                current_time += time[i][1] as i64;
                arrival[room_idx] = current_time;
                pq.push(-current_time - time[i][2] as i64);

            } else {
                let next_available_time = if pq.is_empty() {
                    current_time
                } else {
                    -pq.peek().unwrap()
                };

                current_time = next_available_time + time[i][1] as i64;
                arrival[room_idx] = current_time;
                pq.push(-current_time - time[i][2] as i64);
            }
        }

        *arrival.last().unwrap()
    }
}