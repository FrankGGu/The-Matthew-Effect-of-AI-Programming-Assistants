impl Solution {
    pub fn can_visit_all_rooms(rooms: Vec<Vec<i32>>) -> bool {
        let n = rooms.len();
        let mut visited = vec![false; n];
        let mut stack = vec![0];
        visited[0] = true;

        while let Some(room) = stack.pop() {
            for &key in &rooms[room] {
                let key = key as usize;
                if !visited[key] {
                    visited[key] = true;
                    stack.push(key);
                }
            }
        }

        visited.iter().all(|&v| v)
    }
}