impl Solution {
    pub fn sum_four_divisors(nums: Vec<i32>) -> i32 {
        let mut total = 0;
        for &num in nums.iter() {
            let mut divisors = Vec::new();
            let sqrt_num = (num as f64).sqrt() as i32;
            for i in 1..=sqrt_num {
                if num % i == 0 {
                    divisors.push(i);
                    if i != num / i {
                        divisors.push(num / i);
                    }
                }
            }
            if divisors.len() == 4 {
                total += divisors.iter().sum::<i32>();
            }
        }
        total
    }
}