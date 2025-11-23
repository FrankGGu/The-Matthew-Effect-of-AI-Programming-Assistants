use std::collections::VecDeque;

impl Solution {
    pub fn can_reach(arr: Vec<i32>, start: i32) -> bool {
        let n = arr.len();
        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(start as usize);
        visited[start as usize] = true;

        while !queue.is_empty() {
            let curr = queue.pop_front().unwrap();
            if arr[curr] == 0 {
                return true;
            }

            let next1 = curr as i32 + arr[curr];
            let next2 = curr as i32 - arr[curr];

            if next1 >= 0 && next1 < n as i32 && !visited[next1 as usize] {
                queue.push_back(next1 as usize);
                visited[next1 as usize] = true;
            }

            if next2 >= 0 && next2 < n as i32 && !visited[next2 as usize] {
                queue.push_back(next2 as usize);
                visited[next2 as usize] = true;
            }
        }

        false
    }
}