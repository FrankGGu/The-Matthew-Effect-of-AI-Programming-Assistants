impl Solution {
    pub fn max_subarrays(nums: Vec<i32>) -> i32 {
        let mut and_total = nums[0];
        for &num in nums.iter().skip(1) {
            and_total &= num;
        }
        if and_total != 0 {
            return 1;
        }

        let mut res = 0;
        let mut current_and = !0;
        for &num in nums.iter() {
            current_and &= num;
            if current_and == 0 {
                res += 1;
                current_and = !0;
            }
        }
        res
    }
}