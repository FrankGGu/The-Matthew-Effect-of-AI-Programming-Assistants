impl Solution {
    pub fn max_sub_array_len(nums: Vec<i32>, k: i32) -> i32 {
        use std::collections::HashMap;
        let mut prefix_sum = 0;
        let mut max_len = 0;
        let mut map = HashMap::new();
        map.insert(0, -1);

        for (i, &num) in nums.iter().enumerate() {
            prefix_sum += num;
            let remainder = ((prefix_sum % k) + k) % k;
            if let Some(&prev_index) = map.get(&remainder) {
                max_len = max_len.max(i as i32 - prev_index);
            } else {
                map.insert(remainder, i as i32);
            }
        }

        max_len
    }
}