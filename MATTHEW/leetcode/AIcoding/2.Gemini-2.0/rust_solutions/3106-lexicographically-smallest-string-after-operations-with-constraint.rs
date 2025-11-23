use std::collections::VecDeque;

impl Solution {
    pub fn lexicographically_smallest_string_after_operations(s: String, a: i32, b: i32) -> String {
        let n = s.len();
        let s = s.as_bytes();
        let mut visited = vec![false; n];
        let mut q = VecDeque::new();
        let mut ans = String::new();
        ans.push_str(&String::from_utf8_lossy(s));

        q.push_back(s.to_vec());
        visited[0] = true;

        while let Some(curr) = q.pop_front() {
            let curr_str = String::from_utf8_lossy(&curr);
            if curr_str < ans {
                ans = curr_str.to_string();
            }

            let mut add = curr.clone();
            for i in 1..n {
                if i % 2 == 1 {
                    add[i] = ((add[i] - b'0' + a as u8) % 10 + b'0') as u8;
                }
            }

            let add_idx = add.iter().zip(s.iter()).map(|(x,y)| (x - y) as i32).sum::<i32>().abs() as usize % n;
            if !visited[add_idx] {
                visited[add_idx] = true;
                q.push_back(add);
            }

            let mut rotate = curr.clone();
            rotate.rotate_right(b as usize);
            let rotate_idx = rotate.iter().zip(s.iter()).map(|(x,y)| (x - y) as i32).sum::<i32>().abs() as usize % n;

            if !visited[rotate_idx] {
                visited[rotate_idx] = true;
                q.push_back(rotate);
            }
        }

        ans
    }
}