impl Solution {
    pub fn largest_perimeter(mut nums: Vec<i32>) -> i64 {
        nums.sort();
        let mut sum = 0;
        for i in 0..nums.len() - 1 {
            sum += nums[i] as i64;
        }
        let mut ans = -1;
        for i in (2..nums.len()).rev() {
            if sum > nums[i] as i64 {
                ans = sum + nums[i] as i64;
                break;
            } else {
                sum -= nums[i - 1] as i64;
            }
        }
        ans
    }
}