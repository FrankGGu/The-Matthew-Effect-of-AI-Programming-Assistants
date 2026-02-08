impl Solution {
    pub fn maximum_number_of_removable_characters(s: String, p: String, removable: Vec<i32>) -> i32 {
        let s_bytes = s.as_bytes();
        let p_bytes = p.as_bytes();
        let n = s.len();
        let m = p.len();
        let r_len = removable.len();

        let mut left = 0;
        let mut right = r_len as i32;
        let mut ans = 0;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut removed = vec![false; n];

            for i in 0..mid as usize {
                removed[removable[i] as usize] = true;
            }

            let mut s_idx = 0;
            let mut p_idx = 0;

            while s_idx < n && p_idx < m {
                if s_bytes[s_idx] == p_bytes[p_idx] && !removed[s_idx] {
                    p_idx += 1;
                }
                s_idx += 1;
            }

            if p_idx == m {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        ans
    }
}