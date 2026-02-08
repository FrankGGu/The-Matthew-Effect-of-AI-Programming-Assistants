impl Solution {
    pub fn reverse_string2(s: String, k: i32) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let k = k as usize;

        for i in (0..n).step_by(2 * k) {
            let mut start = i;
            let mut end = std::cmp::min(i + k - 1, n - 1);

            while start < end {
                chars.swap(start, end);
                start += 1;
                end -= 1;
            }
        }

        chars.into_iter().collect()
    }
}