impl Solution {
    pub fn max_divisible(nums: Vec<i32>, divisors: Vec<i32>) -> i32 {
        let mut max_score = -1;
        let mut result = -1;

        for &divisor in &divisors {
            let mut score = 0;
            for &num in &nums {
                if num % divisor == 0 {
                    score += 1;
                }
            }

            if score > max_score {
                max_score = score;
                result = divisor;
            } else if score == max_score && divisor < result {
                result = divisor;
            }
        }

        result
    }
}