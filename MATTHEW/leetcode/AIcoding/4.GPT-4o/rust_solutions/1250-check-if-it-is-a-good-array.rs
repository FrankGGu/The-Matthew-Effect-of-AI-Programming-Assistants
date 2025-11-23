impl Solution {
    pub fn is_good_array(nums: Vec<i32>) -> bool {
        let mut gcd = nums[0];
        for &num in &nums[1..] {
            gcd = Self::gcd(gcd, num);
            if gcd == 1 {
                return true;
            }
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