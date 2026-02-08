impl Solution {
    pub fn dominant_index(nums: Vec<i32>) -> i32 {
        let mut max_val = i32::min_value();
        let mut max_index = -1;
        for (i, &num) in nums.iter().enumerate() {
            if num > max_val {
                max_val = num;
                max_index = i as i32;
            }
        }

        for &num in nums.iter() {
            if num != max_val && max_val < num * 2 {
                return -1;
            }
        }

        max_index
    }
}