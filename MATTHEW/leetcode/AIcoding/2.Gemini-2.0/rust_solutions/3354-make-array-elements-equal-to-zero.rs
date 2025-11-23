impl Solution {
    pub fn make_equal(heights: Vec<i32>) -> bool {
        let mut sum: i64 = 0;
        for &h in &heights {
            sum += h as i64;
        }
        sum % 3 == 0
    }
}