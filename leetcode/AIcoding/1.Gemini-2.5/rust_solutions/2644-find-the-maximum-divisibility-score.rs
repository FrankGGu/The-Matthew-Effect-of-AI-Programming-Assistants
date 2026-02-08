impl Solution {
    pub fn max_divisibility_score(nums: Vec<i32>, divisors: Vec<i32>) -> i32 {
        let mut max_score = -1;
        let mut result_divisor = i32::MAX;

        for &d in divisors.iter() {
            let mut current_score = 0;
            for &n in nums.iter() {
                if n % d == 0 {
                    current_score += 1;
                }
            }

            if current_score > max_score {
                max_score = current_score;
                result_divisor = d;
            } else if current_score == max_score {
                result_divisor = result_divisor.min(d);
            }
        }

        result_divisor
    }
}