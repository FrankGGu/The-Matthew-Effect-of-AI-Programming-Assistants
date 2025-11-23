struct Solution;

impl Solution {
    pub fn num_subarrays_with_bounded_max(nums: Vec<i32>, left: i32, right: i32) -> i32 {
        let mut result = 0;
        let mut last = -1;
        let mut prev = -1;

        for (i, &num) in nums.iter().enumerate() {
            if num >= left && num <= right {
                prev = i as i32;
            } else if num > right {
                last = i as i32;
            }
            result += prev - last;
        }

        result
    }
}