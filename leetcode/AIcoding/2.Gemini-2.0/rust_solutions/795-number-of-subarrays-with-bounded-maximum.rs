impl Solution {
    pub fn num_subarray_bounded_max(nums: Vec<i32>, left: i32, right: i32) -> i32 {
        let mut count = 0;
        let mut start = -1;
        let mut last_valid = -1;

        for i in 0..nums.len() {
            if nums[i] >= left && nums[i] <= right {
                last_valid = i as i32;
                count += last_valid - start;
            } else if nums[i] < left {
                if last_valid != -1 {
                    count += last_valid - start;
                }
            } else {
                start = i as i32;
                last_valid = -1;
            }
        }

        count
    }
}