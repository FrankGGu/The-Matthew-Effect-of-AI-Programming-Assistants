use std::collections::HashMap;

pub fn recommended_pairs(categories: Vec<String>, user: Vec<String>) -> Vec<Vec<String>> {
    let mut count_map = HashMap::new();
    for cat in categories {
        *count_map.entry(cat).or_insert(0) += 1;
    }

    let mut result = Vec::new();
    for i in 0..user.len() {
        for j in i + 1..user.len() {
            let cat1 = &user[i];
            let cat2 = &user[j];
            if let (Some(&count1), Some(&count2)) = (count_map.get(cat1), count_map.get(cat2)) {
                result.push(vec![cat1.clone(), cat2.clone(), (count1 + count2).to_string()]);
            }
        }
    }

    result
}