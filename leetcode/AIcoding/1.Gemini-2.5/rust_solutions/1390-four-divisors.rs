impl Solution {
    pub fn sum_four_divisors(nums: Vec<i32>) -> i32 {
        let mut total_sum = 0;

        for &num in nums.iter() {
            let mut divisor_count = 0;
            let mut divisor_sum = 0;

            let limit = (num as f64).sqrt() as i32;

            for i in 1..=limit {
                if num % i == 0 {
                    if i * i == num {
                        divisor_count += 1;
                        divisor_sum += i;
                    } else {
                        divisor_count += 2;
                        divisor_sum += i + num / i;
                    }
                }

                if divisor_count > 4 {
                    break; 
                }
            }

            if divisor_count == 4 {
                total_sum += divisor_sum;
            }
        }

        total_sum
    }
}