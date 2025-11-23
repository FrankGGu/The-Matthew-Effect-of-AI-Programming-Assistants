impl Solution {
    pub fn max_factor_score(nums: Vec<i32>) -> i32 {
        let mut max_score = 0;
        let mut max_factor = 0;

        for i in 1..=100 {
            let mut score = 0;
            for &num in &nums {
                if num % i == 0 {
                    score += i;
                }
            }
            if score > max_score || (score == max_score && i > max_factor) {
                max_score = score;
                max_factor = i;
            }
        }
        max_factor
    }
}