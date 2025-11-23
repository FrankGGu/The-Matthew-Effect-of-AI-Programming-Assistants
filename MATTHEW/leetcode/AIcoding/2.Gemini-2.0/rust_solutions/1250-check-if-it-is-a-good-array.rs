impl Solution {
    pub fn is_good_array(nums: Vec<i32>) -> bool {
        let mut gcd = nums[0];
        for i in 1..nums.len() {
            gcd = Self::gcd(gcd, nums[i]);
        }
        gcd == 1
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}