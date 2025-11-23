use std::collections::HashMap;

pub fn max_elegance(nums: Vec<Vec<i32>>, k: i32) -> i64 {
    let mut nums = nums;
    nums.sort_by(|a, b| b[1].cmp(&a[1]));

    let mut max_elegance = 0;
    let mut current_elegance = 0;
    let mut current_count = 0;
    let mut count_map = HashMap::new();

    for i in 0..nums.len() {
        if current_count < k {
            current_elegance += nums[i][1];
            count_map.insert(nums[i][0], count_map.get(&nums[i][0]).unwrap_or(&0) + 1);
            current_count += 1;
        } else {
            if let Some(&min_val) = count_map.keys().min() {
                if nums[i][0] > min_val {
                    current_elegance -= count_map[min_val] * min_val;
                    current_elegance += nums[i][1];
                    count_map.remove(&min_val);
                    count_map.insert(nums[i][0], count_map.get(&nums[i][0]).unwrap_or(&0) + 1);
                }
            }
        }
        if current_count == k {
            max_elegance = max_elegance.max(current_elegance + (current_count * current_count) as i64);
        }
    }

    max_elegance
}