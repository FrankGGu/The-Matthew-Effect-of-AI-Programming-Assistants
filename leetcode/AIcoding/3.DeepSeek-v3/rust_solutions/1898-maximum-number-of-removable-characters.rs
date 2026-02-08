impl Solution {
    pub fn maximum_removals(s: String, p: String, removable: Vec<i32>) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let p_chars: Vec<char> = p.chars().collect();
        let mut left = 0;
        let mut right = removable.len() as i32;
        let mut result = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut removed = vec![false; s_chars.len()];
            for i in 0..mid as usize {
                removed[removable[i] as usize] = true;
            }
            if Self::is_subsequence(&s_chars, &p_chars, &removed) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        result
    }

    fn is_subsequence(s: &[char], p: &[char], removed: &[bool]) -> bool {
        let mut i = 0;
        let mut j = 0;
        while i < s.len() && j < p.len() {
            if !removed[i] && s[i] == p[j] {
                j += 1;
            }
            i += 1;
        }
        j == p.len()
    }
}