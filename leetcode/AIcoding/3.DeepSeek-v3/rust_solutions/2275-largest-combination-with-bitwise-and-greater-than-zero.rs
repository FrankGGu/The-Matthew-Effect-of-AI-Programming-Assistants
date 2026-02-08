impl Solution {
    pub fn largest_combination(candidates: Vec<i32>) -> i32 {
        let mut max = 0;
        for i in 0..32 {
            let mut count = 0;
            for &num in &candidates {
                if (num >> i) & 1 == 1 {
                    count += 1;
                }
            }
            max = max.max(count);
        }
        max
    }
}