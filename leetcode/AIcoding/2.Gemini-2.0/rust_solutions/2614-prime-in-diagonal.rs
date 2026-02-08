impl Solution {
    pub fn diagonal_prime(nums: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut max_prime = 0;
        for i in 0..n {
            if Self::is_prime(nums[i][i]) {
                max_prime = max_prime.max(nums[i][i]);
            }
            if Self::is_prime(nums[i][n - 1 - i]) {
                max_prime = max_prime.max(nums[i][n - 1 - i]);
            }
        }
        max_prime
    }

    fn is_prime(num: i32) -> bool {
        if num <= 1 {
            return false;
        }
        let num_sqrt = (num as f64).sqrt() as i32;
        for i in 2..=num_sqrt {
            if num % i == 0 {
                return false;
            }
        }
        true
    }
}