struct Solution;

impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();

        let mut ones_count = 0;
        for &num in &nums {
            if num == 1 {
                ones_count += 1;
            }
        }

        if ones_count > 0 {
            return (n - ones_count) as i32;
        }

        let mut min_ops_to_create_one = n + 1;

        for i in 0..n {
            let mut current_gcd = nums[i];
            for j in (i + 1)..n {
                current_gcd = Self::gcd(current_gcd, nums[j]);
                if current_gcd == 1 {
                    min_ops_to_create_one = min_ops_to_create_one.min(j - i);
                    break;
                }
            }
        }

        if min_ops_to_create_one == n + 1 {
            -1
        } else {
            (min_ops_to_create_one + (n - 1)) as i32
        }
    }
}