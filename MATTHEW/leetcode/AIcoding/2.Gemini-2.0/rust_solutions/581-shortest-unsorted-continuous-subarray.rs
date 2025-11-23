impl Solution {
    pub fn find_unsorted_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut start = -1;
        let mut end = -2;
        let mut max_val = nums[0];
        let mut min_val = nums[n - 1];

        for i in 1..n {
            max_val = max_val.max(nums[i]);
            min_val = min_val.min(nums[n - 1 - i]);

            if nums[i] < max_val {
                end = i as i32;
            }

            if nums[n - 1 - i] > min_val {
                start = (n - 1 - i) as i32;
            }
        }

        end - start + 1
    }
}