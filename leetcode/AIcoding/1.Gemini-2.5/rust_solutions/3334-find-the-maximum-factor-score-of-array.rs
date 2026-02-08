use std::collections::HashSet;

impl Solution {
    pub fn find_the_maximum_factor_score(nums: Vec<i32>) -> i32 {
        let nums_set: HashSet<i32> = nums.iter().cloned().collect();

        let mut max_score = -1;
        let mut result = -1;

        for &num in nums.iter() {
            let mut current_score = 0;
            let limit = (num as f64).sqrt() as i32;

            for i in 1..=limit {
                if num % i == 0 {
                    // Factor 1
                    if nums_set.contains(&i) {
                        current_score += 1;
                    }

                    // Factor 2 (num / i)
                    // Check if factor2 is distinct from factor1
                    if i * i != num { 
                        let factor2 = num / i;
                        if nums_set.contains(&factor2) {
                            current_score += 1;
                        }
                    }
                }
            }

            if current_score > max_score {
                max_score = current_score;
                result = num;
            } else if current_score == max_score {
                result = result.min(num);
            }
        }

        result
    }
}