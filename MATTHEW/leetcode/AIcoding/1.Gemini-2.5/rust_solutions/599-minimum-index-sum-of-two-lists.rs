use std::collections::HashMap;

impl Solution {
    pub fn find_restaurant(list1: Vec<String>, list2: Vec<String>) -> Vec<String> {
        let mut map1: HashMap<&str, usize> = HashMap::new();
        for (i, s) in list1.iter().enumerate() {
            map1.insert(s, i);
        }

        let mut min_sum = i32::MAX;
        let mut result: Vec<String> = Vec::new();

        for (j, s2) in list2.iter().enumerate() {
            if let Some(&i) = map1.get(s2.as_str()) {
                let current_sum = (i + j) as i32;
                if current_sum < min_sum {
                    min_sum = current_sum;
                    result.clear();
                    result.push(s2.clone());
                } else if current_sum == min_sum {
                    result.push(s2.clone());
                }
            }
        }
        result
    }
}