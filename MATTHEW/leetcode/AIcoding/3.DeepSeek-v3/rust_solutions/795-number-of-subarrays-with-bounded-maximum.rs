impl Solution {
    pub fn num_subarray_bounded_max(nums: Vec<i32>, left: i32, right: i32) -> i32 {
        let mut res = 0;
        let mut start = 0;
        let mut count = 0;

        for end in 0..nums.len() {
            if nums[end] >= left && nums[end] <= right {
                count = end - start + 1;
                res += count;
            } else if nums[end] < left {
                res += count;
            } else {
                start = end + 1;
                count = 0;
            }
        }

        res as i32
    }
}