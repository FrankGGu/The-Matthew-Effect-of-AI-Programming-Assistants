impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut ones = 0;
        for &num in &nums {
            if num == 1 {
                ones += 1;
            }
        }
        if ones > 0 {
            return nums.len() as i32 - ones;
        }
        let mut min_ops = std::i32::MAX;
        for i in 0..nums.len() {
            for j in i + 1..nums.len() {
                let mut g = nums[i];
                for k in i + 1..=j {
                    g = Self::gcd(g, nums[k]);
                }
                if g == 1 {
                    min_ops = min_ops.min((j - i) as i32);
                }
            }
        }
        if min_ops == std::i32::MAX {
            return -1;
        }
        min_ops + nums.len() as i32 - 1
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}