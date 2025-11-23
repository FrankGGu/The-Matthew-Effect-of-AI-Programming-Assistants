struct Solution;

impl Solution {
    pub fn diagonal_prime(nums: Vec<Vec<i32>>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            let num1 = nums[i][i];
            let num2 = nums[i][n - 1 - i];

            if is_prime(num1) {
                count += 1;
            }
            if is_prime(num2) {
                count += 1;
            }
        }

        count
    }
}

fn is_prime(mut num: i32) -> bool {
    if num < 2 {
        return false;
    }

    for i in 2..=((num as f64).sqrt() as i32) {
        if num % i == 0 {
            return false;
        }
    }

    true
}