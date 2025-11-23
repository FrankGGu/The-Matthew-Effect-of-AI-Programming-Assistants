struct Solution;

impl Solution {
    pub fn remove_almost_equal(s: String) -> String {
        let mut result = Vec::new();
        let chars: Vec<char> = s.chars().collect();

        for c in chars {
            if result.last().map_or(false, |&last| (last as i32 - c as i32).abs() <= 1) {
                continue;
            }
            result.push(c);
        }

        result.into_iter().collect()
    }
}