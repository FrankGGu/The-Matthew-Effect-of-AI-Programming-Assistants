impl Solution {
    pub fn is_good_array(nums: Vec<i32>) -> bool {
        let mut gcd = nums[0];
        for &num in nums.iter().skip(1) {
            gcd = Self::compute_gcd(gcd, num);
            if gcd == 1 {
                break;
            }
        }
        gcd == 1
    }

    fn compute_gcd(mut a: i32, mut b: i32) -> i32 {
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        a
    }
}