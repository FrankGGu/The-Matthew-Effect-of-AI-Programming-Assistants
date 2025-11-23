pub struct Solution {}

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut no_deletion = vec![0; n];
        let mut one_deletion = vec![0; n];

        no_deletion[0] = nums[0];
        one_deletion[0] = nums[0];

        for i in 1..n {
            no_deletion[i] = no_deletion[i - 1].max(0) + nums[i];
            one_deletion[i] = one_deletion[i - 1].max(no_deletion[i - 1] - nums[i - 1]) + nums[i];
        }

        *one_deletion.iter().max().unwrap()
    }
}