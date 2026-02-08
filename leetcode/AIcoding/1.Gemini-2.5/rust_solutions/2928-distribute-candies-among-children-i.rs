impl Solution {
    pub fn distribute_candies(n: i32, limit: i32) -> i32 {
        let mut count = 0;
        for x1 in 0..=limit {
            for x2 in 0..=limit {
                let x3 = n - x1 - x2;
                if x3 >= 0 && x3 <= limit {
                    count += 1;
                }
            }
        }
        count
    }
}