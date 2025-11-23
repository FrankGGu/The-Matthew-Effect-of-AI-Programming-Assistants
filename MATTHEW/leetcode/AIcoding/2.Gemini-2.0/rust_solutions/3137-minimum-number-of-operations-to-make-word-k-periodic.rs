impl Solution {
    pub fn minimum_period(word: String, k: i32) -> i32 {
        let n = word.len();
        let k = k as usize;
        let word_bytes = word.as_bytes();
        let mut ops = 0;
        for i in 0..k {
            let mut counts = std::collections::HashMap::new();
            for j in (i..n).step_by(k) {
                *counts.entry(word_bytes[j]).or_insert(0) += 1;
            }
            let mut max_count = 0;
            for &count in counts.values() {
                max_count = std::cmp::max(max_count, count);
            }
            ops += (n / k + if n % k > i { 1 } else { 0 }) as i32 - max_count;
        }
        ops
    }
}