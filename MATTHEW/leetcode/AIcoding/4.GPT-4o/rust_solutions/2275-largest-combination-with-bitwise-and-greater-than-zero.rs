impl Solution {
    pub fn largest_combination(candidates: Vec<i32>) -> i32 {
        let mut max_count = 0;
        for i in 0..32 {
            let count = candidates.iter().filter(|&&x| (x >> i) & 1 == 1).count();
            max_count = max_count.max(count);
        }
        max_count as i32
    }
}