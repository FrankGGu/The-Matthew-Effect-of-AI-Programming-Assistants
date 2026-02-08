struct Solution;

impl Solution {
    pub fn maximum_removals(s: String, p: String, removable: Vec<i32>) -> i32 {
        let s_bytes = s.as_bytes();
        let p_bytes = p.as_bytes();
        let k_max = removable.len();

        let mut low = 0;
        let mut high = k_max as i32;
        let mut ans = 0;

        while low <= high {
            let mid = low + (high - low) / 2;

            if Self::is_subsequence(s_bytes, p_bytes, &removable, mid as usize) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        ans
    }

    fn is_subsequence(s_bytes: &[u8], p_bytes: &[u8], removable: &[i32], k: usize) -> bool {
        let mut removed_indices = vec![false; s_bytes.len()];
        for i in 0..k {
            removed_indices[removable[i] as usize] = true;
        }

        let mut s_ptr = 0;
        let mut p_ptr = 0;

        while s_ptr < s_bytes.len() && p_ptr < p_bytes.len() {
            if !removed_indices[s_ptr] && s_bytes[s_ptr] == p_bytes[p_ptr] {
                p_ptr += 1;
            }
            s_ptr += 1;
        }

        p_ptr == p_bytes.len()
    }
}