use std::collections::HashMap;

pub fn find_restaurant(list1: Vec<String>, list2: Vec<String>) -> Vec<String> {
    let mut index_map = HashMap::new();
    for (i, restaurant) in list1.iter().enumerate() {
        index_map.insert(restaurant, i);
    }

    let mut min_sum = std::i32::MAX;
    let mut result = Vec::new();

    for (j, restaurant) in list2.iter().enumerate() {
        if let Some(&i) = index_map.get(restaurant) {
            let sum = i as i32 + j as i32;
            if sum < min_sum {
                min_sum = sum;
                result.clear();
                result.push(restaurant.clone());
            } else if sum == min_sum {
                result.push(restaurant.clone());
            }
        }
    }

    result
}