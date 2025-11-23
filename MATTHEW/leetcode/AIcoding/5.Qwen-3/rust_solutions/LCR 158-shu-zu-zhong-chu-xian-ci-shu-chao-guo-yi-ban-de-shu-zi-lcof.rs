struct Solution;

impl Solution {
    pub fn inventory_management(warehouse: Vec<i32>, cnt: i32) -> i32 {
        let mut freq = std::collections::HashMap::new();
        for &item in &warehouse {
            *freq.entry(item).or_insert(0) += 1;
        }
        for (&item, &count) in &freq {
            if count == cnt {
                return item;
            }
        }
        -1
    }
}