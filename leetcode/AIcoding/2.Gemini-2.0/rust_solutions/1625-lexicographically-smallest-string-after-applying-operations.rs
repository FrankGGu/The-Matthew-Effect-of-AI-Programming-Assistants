use std::collections::VecDeque;

impl Solution {
    pub fn find_lex_smallest_string(s: String, a: i32, b: i32) -> String {
        let n = s.len();
        let s_bytes = s.as_bytes();
        let mut visited = vec![false; n];
        let mut queue = VecDeque::new();
        queue.push_back(s.clone());
        visited[0] = true;
        let mut ans = s.clone();

        while let Some(curr) = queue.pop_front() {
            if curr < ans {
                ans = curr.clone();
            }

            let mut rotate = curr.clone();
            rotate.rotate_right(b as usize);

            if !visited[rotate.as_bytes()[0] as usize % n]{
                visited[rotate.as_bytes()[0] as usize % n] = true;
                queue.push_back(rotate);
            }

            let mut add = curr.clone();
            let mut add_bytes = add.as_bytes().to_vec();
            for i in 1..n {
                if i % 2 == 1 {
                    add_bytes[i] = ((add_bytes[i] - b'0' + a as u8) % 10 + b'0') as u8;
                }
            }
            add = String::from_utf8(add_bytes).unwrap();

            if !visited[add.as_bytes()[0] as usize % n]{
                visited[add.as_bytes()[0] as usize % n] = true;
                queue.push_back(add);
            }
        }

        ans
    }
}