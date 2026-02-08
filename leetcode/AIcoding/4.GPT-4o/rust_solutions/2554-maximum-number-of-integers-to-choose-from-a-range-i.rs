impl Solution {
    pub fn max_integers(start: i32, end: i32, max_sum: i32) -> i32 {
        let mut count = 0;
        let mut sum = 0;
        for i in start..=end {
            sum += i;
            if sum > max_sum {
                break;
            }
            count += 1;
        }
        count
    }
}