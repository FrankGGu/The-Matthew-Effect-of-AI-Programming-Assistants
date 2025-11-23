use std::collections::HashMap;

impl Solution {
    pub fn array_change(nums: Vec<i32>, operations: Vec<Vec<i32>>) -> Vec<i32> {
        let mut map: HashMap<i32, usize> = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            map.insert(num, i);
        }

        let mut result = nums.clone();
        for op in operations {
            let index = map.get(&op[0]).unwrap();
            result[*index] = op[1];
            map.remove(&op[0]);
            map.insert(op[1], *index);
        }

        result
    }
}