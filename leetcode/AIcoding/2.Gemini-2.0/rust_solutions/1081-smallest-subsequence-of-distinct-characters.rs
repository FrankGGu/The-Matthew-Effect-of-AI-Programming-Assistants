impl Solution {
    pub fn smallest_subsequence(s: String) -> String {
        let mut last_occurrence = vec![0; 26];
        let mut seen = vec![false; 26];
        let s_bytes = s.as_bytes();

        for (i, &c) in s_bytes.iter().enumerate() {
            last_occurrence[(c - b'a') as usize] = i;
        }

        let mut stack: Vec<u8> = Vec::new();

        for (i, &c) in s_bytes.iter().enumerate() {
            let idx = (c - b'a') as usize;
            if seen[idx] {
                continue;
            }

            while !stack.is_empty() && *stack.last().unwrap() > c && last_occurrence[(stack.last().unwrap() - b'a') as usize] > i {
                seen[(stack.pop().unwrap() - b'a') as usize] = false;
            }

            stack.push(c);
            seen[idx] = true;
        }

        String::from_utf8(stack).unwrap()
    }
}