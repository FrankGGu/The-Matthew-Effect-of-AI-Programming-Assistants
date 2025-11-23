use std::collections::VecDeque;

impl Solution {
    pub fn can_visit_all_rooms(rooms: Vec<Vec<i32>>) -> bool {
        let n = rooms.len();
        if n == 0 {
            return true;
        }

        let mut visited = vec![false; n];
        let mut q = VecDeque::new();
        let mut visited_count = 0;

        // Start at room 0
        q.push_back(0);
        visited[0] = true;
        visited_count += 1;

        while let Some(room_idx) = q.pop_front() {
            for &key in rooms[room_idx].iter() {
                let next_room_idx = key as usize;
                if !visited[next_room_idx] {
                    visited[next_room_idx] = true;
                    visited_count += 1;
                    q.push_back(next_room_idx);
                }
            }
        }

        visited_count == n
    }
}