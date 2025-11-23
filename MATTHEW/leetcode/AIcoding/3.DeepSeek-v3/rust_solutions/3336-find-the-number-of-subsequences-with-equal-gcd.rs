impl Solution {
    pub fn count_subsequences_with_equal_gcd(nums: Vec<i32>) -> i32 {
        let max_num = *nums.iter().max().unwrap_or(&0);
        let mut dp = vec![0; (max_num + 1) as usize];
        let mut res = 0;

        for &num in nums.iter() {
            let mut divisors = Vec::new();
            for d in 1..=((num as f64).sqrt() as i32) {
                if num % d == 0 {
                    divisors.push(d);
                    if d != num / d {
                        divisors.push(num / d);
                    }
                }
            }

            for &d in divisors.iter() {
                res += dp[d as usize];
                dp[d as usize] += 1;
            }
        }

        res
    }
}