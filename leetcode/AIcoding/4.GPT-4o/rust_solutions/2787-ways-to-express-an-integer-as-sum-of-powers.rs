impl Solution {
    pub fn count_expressible_integers(n: i32) -> i32 {
        let mut count = 0;
        for k in 1..=30 {
            let mut sum = 0;
            let mut power = 1;
            while sum < n {
                sum += power;
                power *= k;
            }
            if sum == n {
                count += 1;
            }
        }
        count
    }
}