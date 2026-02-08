impl Solution {
    pub fn find_max_length(nums: Vec<i32>) -> i32 {
        let mut count_map = std::collections::HashMap::new();
        count_map.insert(0, -1);
        let mut max_length = 0;
        let mut count = 0;

        for i in 0..nums.len() {
            count += if nums[i] == 0 { -1 } else { 1 };
            if let Some(&index) = count_map.get(&count) {
                max_length = max_length.max(i as i32 - index);
            } else {
                count_map.insert(count, i as i32);
            }
        }
        max_length
    }
}