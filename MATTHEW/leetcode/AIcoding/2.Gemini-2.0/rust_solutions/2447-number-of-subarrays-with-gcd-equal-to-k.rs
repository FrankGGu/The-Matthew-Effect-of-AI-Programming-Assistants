impl Solution {
    pub fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }

    pub fn subarray_gcd(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        for i in 0..nums.len() {
            let mut current_gcd = 0;
            for j in i..nums.len() {
                current_gcd = Solution::gcd(current_gcd, nums[j]);
                if current_gcd == k {
                    count += 1;
                }
                if current_gcd < k {
                    break;
                }
            }
        }
        count
    }
}