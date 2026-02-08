impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut min_ops = std::i32::MAX;
        let mut count_ones = 0;

        for &num in &nums {
            if num == 1 {
                count_ones += 1;
            }
        }

        if count_ones > 0 {
            return (n - count_ones) as i32;
        }

        for i in 0..n {
            let mut current_gcd = nums[i];
            for j in i + 1..n {
                current_gcd = gcd(current_gcd, nums[j]);
                if current_gcd == 1 {
                    min_ops = min_ops.min((j - i) as i32 + (n - 1) as i32);
                    break;
                }
            }
        }

        if min_ops == std::i32::MAX {
            -1
        } else {
            min_ops
        }
    }
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}