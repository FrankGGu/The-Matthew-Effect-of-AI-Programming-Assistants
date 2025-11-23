impl Solution {
    pub fn max_factor_score(nums: Vec<i32>) -> i64 {
        let mut max_score = 0;
        for &num in &nums {
            let mut score = 0;
            let mut i = 1;
            while i * i <= num {
                if num % i == 0 {
                    if i * i == num {
                        score += i;
                    } else {
                        score += i + num / i;
                    }
                }
                i += 1;
            }
            max_score = max_score.max(score as i64);
        }
        max_score
    }
}