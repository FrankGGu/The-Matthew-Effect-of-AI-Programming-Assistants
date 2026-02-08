impl Solution {
    pub fn zero_array(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let n = nums.len();
        let mut ops = 0;

        while nums.iter().any(|&x| x != 0) {
            let mut start = -1;
            let mut end = -1;

            for i in 0..n {
                if nums[i] != 0 {
                    start = i as i32;
                    break;
                }
            }

            if start == -1 {
                break;
            }

            for i in (0..n).rev() {
                if nums[i] != 0 {
                    end = i as i32;
                    break;
                }
            }

            if end == -1 {
                break;
            }

            if start > end {
                break;
            }

            let min_val = nums[(start as usize)..(end as usize + 1)].iter().filter(|&&x| x > 0).min().cloned().unwrap_or(0);

            if min_val == 0 {
               break;
            }

            for i in (start as usize)..(end as usize + 1) {
                if nums[i] > 0 {
                    nums[i] -= min_val;
                }
            }

            ops += 1;
        }

        ops
    }
}