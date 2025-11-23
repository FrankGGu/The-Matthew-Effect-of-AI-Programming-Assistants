impl Solution {
    pub fn dominant_index(nums: Vec<i32>) -> i32 {
        let mut max_index = 0;
        let mut max_value = nums[0];

        for (i, &num) in nums.iter().enumerate() {
            if num > max_value {
                max_value = num;
                max_index = i;
            }
        }

        for (i, &num) in nums.iter().enumerate() {
            if i != max_index && num * 2 > max_value {
                return -1;
            }
        }

        max_index as i32
    }
}