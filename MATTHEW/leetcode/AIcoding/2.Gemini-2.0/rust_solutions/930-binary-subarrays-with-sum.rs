impl Solution {
    pub fn num_subarrays_with_sum(nums: Vec<i32>, goal: i32) -> i32 {
        let mut count = 0;
        let mut prefix_sum = std::collections::HashMap::new();
        prefix_sum.insert(0, 1);
        let mut current_sum = 0;

        for &num in &nums {
            current_sum += num;
            let complement = current_sum - goal;
            if prefix_sum.contains_key(&complement) {
                count += prefix_sum.get(&complement).unwrap();
            }
            *prefix_sum.entry(current_sum).or_insert(0) += 1;
        }

        count
    }
}