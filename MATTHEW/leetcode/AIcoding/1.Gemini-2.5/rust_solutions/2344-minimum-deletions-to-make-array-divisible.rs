impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn min_deletions(nums: Vec<i32>, nums_divide: Vec<i32>) -> i32 {
        let mut common_divisor = nums_divide[0];
        for i in 1..nums_divide.len() {
            common_divisor = Self::gcd(common_divisor, nums_divide[i]);
        }

        let mut sorted_nums = nums;
        sorted_nums.sort_unstable();

        for i in 0..sorted_nums.len() {
            if common_divisor % sorted_nums[i] == 0 {
                return i as i32;
            }
        }

        -1
    }
}