impl Solution {
    pub fn maximum_removals(s: String, p: String, removable: Vec<i32>) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let p_chars: Vec<char> = p.chars().collect();
        let n = removable.len();
        let mut left = 0;
        let mut right = n as i32 - 1;
        let mut ans = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut removed = vec![false; s_chars.len()];
            for i in 0..=mid {
                removed[removable[i as usize] as usize] = true;
            }

            let mut s_idx = 0;
            let mut p_idx = 0;

            while s_idx < s_chars.len() && p_idx < p_chars.len() {
                if !removed[s_idx] && s_chars[s_idx] == p_chars[p_idx] {
                    p_idx += 1;
                }
                s_idx += 1;
            }

            if p_idx == p_chars.len() {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        ans + 1
    }
}