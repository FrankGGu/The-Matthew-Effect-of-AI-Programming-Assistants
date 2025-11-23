use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn most_booked(n: i32, meetings: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut meetings = meetings;
        meetings.sort_unstable();

        let mut available: BinaryHeap<Reverse<usize>> = (0..n).map(Reverse).collect();
        let mut busy: BinaryHeap<Reverse<(i64, usize)>> = BinaryHeap::new();
        let mut count = vec![0; n];

        for meeting in meetings {
            let (start, end) = (meeting[0] as i64, meeting[1] as i64);

            while let Some(Reverse((end_time, room))) = busy.peek() {
                if *end_time > start {
                    break;
                }
                available.push(Reverse(*room));
                busy.pop();
            }

            if let Some(Reverse(room)) = available.pop() {
                busy.push(Reverse((end, room)));
                count[room] += 1;
            } else {
                let Reverse((earliest_end, room)) = busy.pop().unwrap();
                let duration = end - start;
                busy.push(Reverse((earliest_end + duration, room)));
                count[room] += 1;
            }
        }

        count.iter().enumerate().max_by_key(|&(i, &cnt)| (cnt, -(i as i32))).unwrap().0 as i32
    }
}