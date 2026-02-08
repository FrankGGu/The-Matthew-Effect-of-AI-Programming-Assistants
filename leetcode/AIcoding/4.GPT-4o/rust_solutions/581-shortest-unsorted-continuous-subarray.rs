impl Solution {
    pub fn find_unsorted_subarray(nums: Vec<i32>) -> i32 {
        let mut start = nums.len();
        let mut end = 0;
        let mut sorted = nums.clone();
        sorted.sort();

        for i in 0..nums.len() {
            if nums[i] != sorted[i] {
                start = start.min(i);
                end = end.max(i);
            }
        }

        if end - start > 0 {
            (end - start + 1) as i32
        } else {
            0
        }
    }
}