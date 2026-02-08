impl Solution {
    pub fn count_triplets(n: i32) -> i32 {
        let mut count = 0;
        for a in 1..=n {
            for b in 1..=n {
                let c_sq = a * a + b * b;
                let c = (c_sq as f64).sqrt() as i32;
                if c * c == c_sq && c <= n {
                    count += 1;
                }
            }
        }
        count
    }
}