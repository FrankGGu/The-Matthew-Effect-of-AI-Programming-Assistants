impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn is_good_array(nums: Vec<i32>) -> bool {
        let mut current_gcd = nums[0];

        for i in 1..nums.len() {
            current_gcd = Self::gcd(current_gcd, nums[i]);
            if current_gcd == 1 {
                return true;
            }
        }

        current_gcd == 1
    }
}