impl Solution {
    pub fn orderly_queue(s: String, k: i32) -> String {
        if k == 1 {
            let mut chars: Vec<_> = s.chars().collect();
            let n = chars.len();
            let mut result = s.clone();
            for i in 0..n {
                chars.rotate_left(1);
                let candidate: String = chars.iter().collect();
                result = result.min(candidate);
            }
            result
        } else {
            let mut chars: Vec<_> = s.chars().collect();
            chars.sort();
            chars.iter().collect()
        }
    }
}