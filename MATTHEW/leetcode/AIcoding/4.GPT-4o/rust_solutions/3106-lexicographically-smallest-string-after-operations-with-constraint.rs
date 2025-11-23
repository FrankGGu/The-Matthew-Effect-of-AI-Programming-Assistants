impl Solution {
    pub fn find_lex_smallest_string(s: String, a: i32, k: i32) -> String {
        let n = s.len();
        let mut visited = vec![false; n];
        let mut result = s.clone();
        let mut queue = std::collections::VecDeque::new();
        queue.push_back(s.clone());
        visited[0] = true;

        while let Some(current) = queue.pop_front() {
            if current < result {
                result = current.clone();
            }

            let chars: Vec<char> = current.chars().collect();
            for i in 0..n {
                let mut new_chars = chars.clone();
                new_chars[i] = ((new_chars[i] as u8 - b'0' + a as u8) % 10 + b'0') as char);
                let new_string: String = new_chars.iter().collect();
                if !visited[i] {
                    visited[i] = true;
                    queue.push_back(new_string);
                }
            }

            if k > 0 {
                let mut rotated = current.chars().cycle().skip(k as usize).take(n).collect::<String>();
                if rotated < result {
                    result = rotated.clone();
                }
                if !visited[n - 1] {
                    visited[n - 1] = true;
                    queue.push_back(rotated);
                }
            }
        }
        result
    }
}