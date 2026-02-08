use std::collections::HashMap;

impl Solution {
    pub fn find_restaurant(list1: Vec<String>, list2: Vec<String>) -> Vec<String> {
        let mut map1: HashMap<&String, usize> = HashMap::new();
        for (i, s) in list1.iter().enumerate() {
            map1.insert(s, i);
        }

        let mut min_index_sum = std::usize::MAX;
        let mut result: Vec<String> = Vec::new();

        for (i, s) in list2.iter().enumerate() {
            if let Some(&index1) = map1.get(s) {
                let index_sum = index1 + i;
                if index_sum < min_index_sum {
                    min_index_sum = index_sum;
                    result.clear();
                    result.push(s.clone());
                } else if index_sum == min_index_sum {
                    result.push(s.clone());
                }
            }
        }

        result
    }
}