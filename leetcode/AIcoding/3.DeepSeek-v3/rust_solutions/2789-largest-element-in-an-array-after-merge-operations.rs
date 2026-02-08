impl Solution {
    pub fn max_array_value(nums: Vec<i32>) -> i64 {
        let mut nums = nums.into_iter().map(|x| x as i64).collect::<Vec<_>>();
        let mut res = 0;
        let mut i = nums.len() as i32 - 1;
        while i >= 0 {
            let mut sum = nums[i as usize];
            while i > 0 && sum >= nums[(i - 1) as usize] {
                i -= 1;
                sum += nums[i as usize];
            }
            res = res.max(sum);
            i -= 1;
        }
        res
    }
}