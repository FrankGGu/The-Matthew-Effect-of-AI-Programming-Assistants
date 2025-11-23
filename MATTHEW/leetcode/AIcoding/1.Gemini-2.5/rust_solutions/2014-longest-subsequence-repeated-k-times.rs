use std::collections::VecDeque;

impl Solution {
    pub fn longest_subsequence_repeated_k(s: String, k: i32) -> String {
        let s_bytes = s.as_bytes();
        let mut char_counts = [0; 26];
        for &b in s_bytes {
            char_counts[(b - b'a') as usize] += 1;
        }

        let mut eligible_chars: Vec<char> = Vec::new();
        for i in (0..26).rev() { // From 'z' down to 'a' for lexicographical largest
            if char_counts[i] >= k {
                eligible_chars.push((i as u8 + b'a') as char);
            }
        }

        let mut q: VecDeque<String> = VecDeque::new();
        q.push_back(String::new());

        let mut ans = String::new();

        while let Some(curr) = q.pop_front() {
            for &c in &eligible_chars {
                let mut next_s = curr.clone();
                next_s.push(c);

                if Solution::check(&next_s, s_bytes, k) {
                    if next_s.len() > ans.len() {
                        ans = next_s.clone();
                    }
                    // If next_s.len() == ans.len(), no update is needed because
                    // 'eligible_chars' is iterated from 'z' down to 'a',
                    // ensuring that 'ans' already holds the lexicographically largest
                    // string of its current length.
                    q.push_back(next_s);
                }
            }
        }
        ans
    }

    fn check(sub: &str, s: &[u8], k: i32) -> bool {
        let sub_bytes = sub.as_bytes();
        if sub_bytes.is_empty() {
            return true; // An empty string is a valid prefix for building.
        }

        let mut s_idx = 0;
        for _ in 0..k {
            let mut sub_idx = 0;
            let mut temp_s_idx = s_idx;
            while sub_idx < sub_bytes.len() {
                let mut found = false;
                while temp_s_idx < s.len() {
                    if s[temp_s_idx] == sub_bytes[sub_idx] {
                        temp_s_idx += 1;
                        found = true;
                        break;
                    }
                    temp_s_idx += 1;
                }
                if !found {
                    return false;
                }
                sub_idx += 1;
            }
            s_idx = temp_s_idx;
        }
        true
    }
}