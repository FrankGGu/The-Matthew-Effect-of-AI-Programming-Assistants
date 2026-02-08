use std::collections::HashMap;

impl Solution {
    pub fn array_change(nums: Vec<i32>, operations: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = nums;
        let mut map = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            map.insert(num, i);
        }
        for op in operations {
            let old_val = op[0];
            let new_val = op[1];
            if let Some(&index) = map.get(&old_val) {
                nums[index] = new_val;
                map.remove(&old_val);
                map.insert(new_val, index);
            }
        }
        nums
    }
}