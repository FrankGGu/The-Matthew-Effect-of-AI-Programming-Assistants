impl Solution {
    pub fn reverse_str(s: String, k: i32) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let k_usize = k as usize;

        for i in (0..n).step_by(2 * k_usize) {
            let mut left = i;
            let mut right = (i + k_usize).min(n) - 1;

            while left < right {
                chars.swap(left, right);
                left += 1;
                right -= 1;
            }
        }

        chars.into_iter().collect()
    }
}