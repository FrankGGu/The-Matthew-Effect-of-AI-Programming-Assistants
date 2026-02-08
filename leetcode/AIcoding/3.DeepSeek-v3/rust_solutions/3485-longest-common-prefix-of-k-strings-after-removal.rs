impl Solution {
    pub fn longest_common_prefix_k_strings_after_removal(strs: Vec<String>, k: i32) -> String {
        let n = strs.len();
        if n == 0 {
            return String::new();
        }
        let k = k as usize;
        let min_len = strs.iter().map(|s| s.len()).min().unwrap();
        let mut low = 1;
        let mut high = min_len;
        let mut result = 0;

        while low <= high {
            let mid = (low + high) / 2;
            if Self::is_possible(&strs, mid, k) {
                result = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        strs[0][..result].to_string()
    }

    fn is_possible(strs: &[String], len: usize, k: usize) -> bool {
        let n = strs.len();
        let mut count = 0;
        let first = &strs[0][..len];

        for s in strs.iter() {
            if s.len() < len {
                return false;
            }
            if &s[..len] == first {
                count += 1;
            }
        }

        count >= n - k
    }
}