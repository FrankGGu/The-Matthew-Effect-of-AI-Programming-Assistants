impl Solution {
    pub fn missing_observations(observed: Vec<i32>, expected: Vec<i32>) -> Vec<i32> {
        let mut count = std::collections::HashMap::new();
        for &num in expected.iter() {
            *count.entry(num).or_insert(0) += 1;
        }
        for &num in observed.iter() {
            *count.entry(num).or_insert(0) -= 1;
        }
        count.iter()
            .filter_map(|(&key, &val)| {
                if val > 0 {
                    Some(vec![key; val as usize])
                } else {
                    None
                }
            })
            .flatten()
            .collect()
    }
}