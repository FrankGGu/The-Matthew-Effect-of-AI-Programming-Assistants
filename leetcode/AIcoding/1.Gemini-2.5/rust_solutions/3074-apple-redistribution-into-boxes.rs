impl Solution {
    pub fn minimum_boxes(apple: Vec<i32>, capacity: Vec<i32>) -> i32 {
        let total_apples: i32 = apple.iter().sum();
        let mut sorted_capacity = capacity;
        sorted_capacity.sort_unstable_by(|a, b| b.cmp(a));

        let mut boxes_used = 0;
        let mut current_capacity_sum = 0;

        for &cap in sorted_capacity.iter() {
            current_capacity_sum += cap;
            boxes_used += 1;
            if current_capacity_sum >= total_apples {
                return boxes_used;
            }
        }

        0 
    }
}