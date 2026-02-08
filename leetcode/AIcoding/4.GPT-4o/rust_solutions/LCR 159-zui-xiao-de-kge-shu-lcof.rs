use std::collections::HashMap;

pub fn inventory_management(orders: Vec<Vec<i32>>) -> Vec<i32> {
    let mut inventory = HashMap::new();
    for order in orders {
        let item = order[0];
        let amount = order[1];
        *inventory.entry(item).or_insert(0) += amount;
    }
    let mut result: Vec<i32> = inventory.values().cloned().collect();
    result.sort();
    result
}