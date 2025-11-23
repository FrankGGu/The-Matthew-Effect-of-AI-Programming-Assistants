impl Solution {
    pub fn get_maximum_generated(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return 1;
        }

        let n_usize = n as usize;
        let mut nums = vec![0; n_usize + 1];
        nums[0] = 0;
        nums[1] = 1;

        let mut max_val = 1; 

        for i in 1..=(n_usize / 2) {
            if 2 * i <= n_usize {
                nums[2 * i] = nums[i];
                max_val = max_val.max(nums[2 * i]);
            }

            if 2 * i + 1 <= n_usize {
                nums[2 * i + 1] = nums[i] + nums[i + 1];
                max_val = max_val.max(nums[2 * i + 1]);
            }
        }

        max_val
    }
}