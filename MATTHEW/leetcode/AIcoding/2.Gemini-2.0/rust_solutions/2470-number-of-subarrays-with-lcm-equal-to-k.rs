impl Solution {
    pub fn subarray_lcm(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        for i in 0..nums.len() {
            let mut current_lcm = 1;
            for j in i..nums.len() {
                current_lcm = Solution::lcm(current_lcm, nums[j]);
                if current_lcm == k {
                    count += 1;
                } else if current_lcm > k {
                    break;
                }
            }
        }
        count
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Solution::gcd(b, a % b)
        }
    }

    fn lcm(a: i32, b: i32) -> i32 {
        a * b / Solution::gcd(a, b)
    }
}