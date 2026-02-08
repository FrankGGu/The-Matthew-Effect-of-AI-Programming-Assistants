impl Solution {
    pub fn minimum_right_shifts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;
        for i in 1..n {
            if nums[i] < nums[i - 1] {
                count += 1;
            }
        }
        if count == 0 {
            return 0;
        }
        if count > 1 {
            return -1;
        }
        if nums[n - 1] > nums[0] {
            return -1;
        }
        let mut ans = 0;
        for i in 1..n {
            if nums[i] < nums[i - 1] {
                ans = (n - i) as i32;
                break;
            }
        }
        ans
    }
}