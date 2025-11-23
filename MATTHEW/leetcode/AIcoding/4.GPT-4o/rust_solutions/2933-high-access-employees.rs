use std::collections::HashSet;

pub fn high_access_employees(logs: Vec<Vec<i32>>, threshold: i32) -> Vec<i32> {
    let mut access_count = std::collections::HashMap::new();

    for log in logs {
        let employee_id = log[0];
        *access_count.entry(employee_id).or_insert(0) += 1;
    }

    access_count.into_iter()
        .filter(|&(_, count)| count >= threshold)
        .map(|(id, _)| id)
        .collect::<Vec<i32>>()
        .into_iter()
        .sorted()
        .collect()
}