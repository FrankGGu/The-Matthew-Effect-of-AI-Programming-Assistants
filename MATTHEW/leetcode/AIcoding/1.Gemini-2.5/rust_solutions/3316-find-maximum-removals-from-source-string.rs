use std::collections::HashSet;

impl Solution {
    pub fn maximum_removals(s: String, p: String, removals: Vec<i32>) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let p_chars: Vec<char> = p.chars().collect();

        let mut low = 0;
        let mut high = removals.len();
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;
            if mid == 0 { // k = 0, no removals, check if p is subsequence of s
                if Self::is_subsequence(&s_chars, &p_chars, &HashSet::new()) {
                    ans = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
                continue;
            }

            let mut removed_indices = HashSet::with_capacity(mid);
            for i in 0..mid {
                removed_indices.insert(removals[i] as usize);
            }

            if Self::is_subsequence(&s_chars, &p_chars, &removed_indices) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans as i32
    }

    fn is_subsequence(s: &[char], p: &[char], removed_indices: &HashSet<usize>) -> bool {
        let mut s_ptr = 0;
        let mut p_ptr = 0;

        while s_ptr < s.len() && p_ptr < p.len() {
            if removed_indices.contains(&s_ptr) {
                s_ptr += 1;
                continue;
            }

            if s[s_ptr] == p[p_ptr] {
                p_ptr += 1;
            }
            s_ptr += 1;
        }
        p_ptr == p.len()
    }
}