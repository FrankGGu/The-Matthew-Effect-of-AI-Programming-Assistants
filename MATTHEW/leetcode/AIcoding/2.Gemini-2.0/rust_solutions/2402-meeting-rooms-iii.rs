impl Solution {
    pub fn most_booked(n: i32, meetings: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut rooms = vec![0; n];
        let mut available = (0..n as i64).collect::<std::collections::BinaryHeap<_>>();
        let mut occupied = std::collections::BinaryHeap::<(i64, usize)>::new();

        let mut meetings = meetings;
        meetings.sort_unstable();

        for meeting in meetings {
            let start = meeting[0] as i64;
            let end = meeting[1] as i64;

            while !occupied.is_empty() && occupied.peek().unwrap().0 <= start {
                let (_, room) = occupied.pop().unwrap();
                available.push(-(room as i64));
            }

            if !available.is_empty() {
                let room = -available.pop().unwrap() as usize;
                rooms[room] += 1;
                occupied.push((end, room));
            } else {
                let (finish_time, room) = occupied.pop().unwrap();
                rooms[room] += 1;
                occupied.push((finish_time + (end - start), room));
            }
        }

        let mut max_count = 0;
        let mut max_room = 0;
        for i in 0..n {
            if rooms[i] > max_count {
                max_count = rooms[i];
                max_room = i;
            }
        }

        max_room as i32
    }
}