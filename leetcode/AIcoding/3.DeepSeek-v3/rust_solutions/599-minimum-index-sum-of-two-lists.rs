use std::collections::HashMap;

impl Solution {
    pub fn find_restaurant(list1: Vec<String>, list2: Vec<String>) -> Vec<String> {
        let map: HashMap<_, _> = list1.into_iter().enumerate().map(|(i, s)| (s, i)).collect();
        let mut min_sum = usize::MAX;
        let mut result = Vec::new();

        for (j, s) in list2.into_iter().enumerate() {
            if let Some(&i) = map.get(&s) {
                let sum = i + j;
                if sum < min_sum {
                    min_sum = sum;
                    result.clear();
                    result.push(s);
                } else if sum == min_sum {
                    result.push(s);
                }
            }
        }

        result
    }
}