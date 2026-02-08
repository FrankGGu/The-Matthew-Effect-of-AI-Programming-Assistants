impl Solution {
    pub fn judge_square_sum(c: i32) -> bool {
        let mut left = 0;
        let mut right = (c as f64).sqrt() as i32;

        while left <= right {
            let sum = left * left + right * right;
            if sum == c {
                return true;
            } else if sum < c {
                left += 1;
            } else {
                right -= 1;
            }
        }
        false
    }
}