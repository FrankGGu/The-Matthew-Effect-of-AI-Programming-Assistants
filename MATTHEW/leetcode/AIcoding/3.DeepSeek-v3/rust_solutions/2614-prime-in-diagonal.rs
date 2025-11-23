impl Solution {
    pub fn diagonal_prime(nums: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut max_prime = 0;

        for i in 0..n {
            let num1 = nums[i][i];
            let num2 = nums[i][n - 1 - i];

            if num1 > max_prime && Self::is_prime(num1) {
                max_prime = num1;
            }
            if num2 > max_prime && Self::is_prime(num2) {
                max_prime = num2;
            }
        }

        max_prime
    }

    fn is_prime(num: i32) -> bool {
        if num <= 1 {
            return false;
        }
        if num == 2 {
            return true;
        }
        if num % 2 == 0 {
            return false;
        }
        let sqrt_num = (num as f64).sqrt() as i32;
        let mut i = 3;
        while i <= sqrt_num {
            if num % i == 0 {
                return false;
            }
            i += 2;
        }
        true
    }
}