impl Solution {
    pub fn array_change(nums: Vec<i32>, operations: Vec<Vec<i32>>) -> Vec<i32> {
        let mut num_to_index = nums.iter().enumerate().map(|(i, &num)| (num, i)).collect::<std::collections::HashMap<_, _>>();
        let mut result = nums.clone();

        for op in operations {
            let (old, new) = (op[0], op[1]);
            if let Some(&index) = num_to_index.get(&old) {
                result[index] = new;
                num_to_index.remove(&old);
                num_to_index.insert(new, index);
            }
        }

        result
    }
}