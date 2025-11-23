impl Solution {
    pub fn num_subarray_bounded_max(nums: Vec<i32>, left: i32, right: i32) -> i32 {
        let mut count = 0;
        let mut valid_count = 0;
        let mut last_valid_index = -1;

        for (i, &num) in nums.iter().enumerate() {
            if num > right {
                valid_count = 0;
                last_valid_index = i as i32;
            } else if num >= left {
                valid_count = (i as i32 - last_valid_index) + 1;
                count += valid_count;
            } else {
                count += valid_count;
            }
        }

        count
    }
}