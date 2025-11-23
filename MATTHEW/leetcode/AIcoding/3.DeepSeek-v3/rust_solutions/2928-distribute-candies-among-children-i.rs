impl Solution {
    pub fn distribute_candies(n: i32, limit: i32) -> i32 {
        let mut count = 0;
        for a in 0..=limit {
            for b in 0..=limit {
                let c = n - a - b;
                if c >= 0 && c <= limit {
                    count += 1;
                }
            }
        }
        count
    }
}