impl Solution {
    pub fn smallest_subsequence(s: String) -> String {
        let mut stack: Vec<char> = Vec::new();
        let mut last_occurrence = [0; 26];
        let mut visited = [false; 26];

        for (i, c) in s.chars().enumerate() {
            last_occurrence[(c as u8 - b'a') as usize] = i;
        }

        for (i, c) in s.chars().enumerate() {
            let idx = (c as u8 - b'a') as usize;
            if visited[idx] {
                continue;
            }
            while let Some(&top) = stack.last() {
                let top_idx = (top as u8 - b'a') as usize;
                if c < top && i < last_occurrence[top_idx] {
                    visited[top_idx] = false;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push(c);
            visited[idx] = true;
        }

        stack.into_iter().collect()
    }
}