impl Solution {
    pub fn sum_four_divisors(nums: Vec<i32>) -> i32 {
        let mut sum = 0;
        for &num in &nums {
            let mut divisors = Vec::new();
            for i in 1..=((num as f64).sqrt() as i32) {
                if num % i == 0 {
                    if i * i == num {
                        divisors.push(i);
                    } else {
                        divisors.push(i);
                        divisors.push(num / i);
                    }
                }
            }
            if divisors.len() == 4 {
                sum += divisors.iter().sum::<i32>();
            }
        }
        sum
    }
}