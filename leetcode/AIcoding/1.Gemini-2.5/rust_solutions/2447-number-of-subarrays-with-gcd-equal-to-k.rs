impl Solution {
    fn gcd(a: i332, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn subarray_gcd(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            let mut current_gcd = 0;
            for j in i..n {
                if nums[j] % k != 0 {
                    break;
                }

                if current_gcd == 0 {
                    current_gcd = nums[j];
                } else {
                    current_gcd = Self::gcd(current_gcd, nums[j]);
                }

                if current_gcd < k {
                    break;
                }

                if current_gcd == k {
                    count += 1;
                }
            }
        }
        count
    }
}