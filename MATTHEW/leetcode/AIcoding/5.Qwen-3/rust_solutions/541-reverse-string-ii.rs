struct Solution;

impl Solution {
    pub fn reverse_str(s: String, k: i32) -> String {
        let mut s = s.chars().collect::<Vec<char>>();
        let k = k as usize;
        for i in (0..s.len()).step_by(k * 2) {
            let end = std::cmp::min(i + k, s.len());
            s[i..end].reverse();
        }
        s.into_iter().collect()
    }
}