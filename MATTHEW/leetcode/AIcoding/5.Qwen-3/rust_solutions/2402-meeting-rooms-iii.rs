impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn most_booked(mut rooms: Vec<Vec<i32>>, mut meetings: Vec<Vec<i32>>) -> i32 {
        rooms.sort();
        meetings.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut available = BinaryHeap::new();
        for i in 0..rooms.len() {
            available.push(Reverse(i as i32));
        }

        let mut end_time = BinaryHeap::new();
        let mut count = vec![0; rooms.len()];

        for meeting in meetings {
            let start = meeting[0];
            let duration = meeting[1] - start;

            while let Some(end) = end_time.peek().map(|x| x.0) {
                if end <= start {
                    end_time.pop();
                    let room = available.pop().unwrap().0;
                    available.push(Reverse(room));
                } else {
                    break;
                }
            }

            if let Some(Reverse(room)) = available.pop() {
                count[room as usize] += 1;
                end_time.push((start + duration, room));
            } else {
                let (time, room) = end_time.pop().unwrap();
                count[room as usize] += 1;
                end_time.push((time + duration, room));
            }
        }

        let mut max_count = 0;
        let mut result = 0;
        for (i, &c) in count.iter().enumerate() {
            if c > max_count {
                max_count = c;
                result = i as i32;
            }
        }

        result
    }
}
}