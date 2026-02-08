impl Solution {
    pub fn max_divisor_score(nums: Vec<i32>, divisors: Vec<i32>) -> i32 {
        let mut max_score = -1;
        let mut result = std::i32::MAX;

        for &d in &divisors {
            let mut score = 0;
            for &num in &nums {
                if num % d == 0 {
                    score += 1;
                }
            }
            if score > max_score || (score == max_score && d < result) {
                max_score = score;
                result = d;
            }
        }

        result
    }
}