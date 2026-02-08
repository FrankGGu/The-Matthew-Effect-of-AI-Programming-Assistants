impl Solution {
    pub fn longest_well_performing_interval(hours: Vec<i32>) -> i32 {
        let mut max_length = 0;
        let mut count = 0;
        let mut prefix_sum = std::collections::HashMap::new();
        prefix_sum.insert(0, -1);

        for (i, &h) in hours.iter().enumerate() {
            count += if h > 8 { 1 } else { -1 };
            if let Some(&start_index) = prefix_sum.get(&count) {
                max_length = max_length.max(i as i32 - start_index);
            } else {
                prefix_sum.insert(count, i as i32);
            }
        }

        max_length
    }
}