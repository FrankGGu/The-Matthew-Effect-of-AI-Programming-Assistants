use std::collections::VecDeque;

impl Solution {
    pub fn longest_subsequence_repeated_k(&self, s: String, k: i32) -> String {
        let s_bytes = s.as_bytes();
        let n = s.len();
        let mut ans = String::new();

        for len in (1..=n / k as usize).rev() {
            let mut chars: Vec<u8> = Vec::new();
            for i in (b'a'..=b'z').rev() {
                chars.push(i);
            }

            let mut candidates: Vec<String> = Vec::new();
            let mut queue: VecDeque<String> = VecDeque::new();
            for &c in &chars {
                queue.push_back(String::from_utf8(vec![c]).unwrap());
            }

            while let Some(curr) = queue.pop_front() {
                if curr.len() == len {
                    candidates.push(curr);
                } else {
                    for &c in &chars {
                        let mut next = curr.clone();
                        next.push(c as char);
                        queue.push_back(next);
                    }
                }
            }

            for candidate in candidates.iter().rev() {
                let mut count = 0;
                let mut s_idx = 0;
                let mut cand_idx = 0;

                while s_idx < n {
                    if s_bytes[s_idx] as char == candidate.chars().nth(cand_idx).unwrap() {
                        cand_idx += 1;
                        if cand_idx == candidate.len() {
                            count += 1;
                            cand_idx = 0;
                        }
                    }
                    s_idx += 1;
                }

                if count >= k {
                    return candidate.clone();
                }
            }
        }

        ans
    }
}