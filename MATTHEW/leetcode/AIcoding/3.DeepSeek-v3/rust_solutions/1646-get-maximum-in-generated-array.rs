impl Solution {
    pub fn get_maximum_generated(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        let mut nums = vec![0; (n + 1) as usize];
        nums[1] = 1;
        let mut max = 1;
        for i in 2..=n as usize {
            if i % 2 == 0 {
                nums[i] = nums[i / 2];
            } else {
                nums[i] = nums[i / 2] + nums[i / 2 + 1];
            }
            max = max.max(nums[i]);
        }
        max
    }
}