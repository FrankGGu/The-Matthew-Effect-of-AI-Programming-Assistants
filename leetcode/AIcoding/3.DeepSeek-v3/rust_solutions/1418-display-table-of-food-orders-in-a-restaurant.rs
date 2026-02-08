use std::collections::{HashMap, BTreeMap};

impl Solution {
    pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut food_items = BTreeMap::new();
        let mut table_orders = BTreeMap::new();

        for order in orders {
            let table_number = order[1].parse::<i32>().unwrap();
            let food_item = order[2].clone();

            food_items.entry(food_item.clone()).or_insert(());
            let table_entry = table_orders.entry(table_number).or_insert_with(HashMap::new);
            *table_entry.entry(food_item).or_insert(0) += 1;
        }

        let mut sorted_food_items: Vec<String> = food_items.keys().cloned().collect();
        sorted_food_items.sort();

        let mut result = Vec::new();
        let mut header = vec!["Table".to_string()];
        header.extend(sorted_food_items.iter().cloned());
        result.push(header);

        for (table_number, orders_map) in table_orders {
            let mut row = vec![table_number.to_string()];
            for food_item in &sorted_food_items {
                let count = orders_map.get(food_item).unwrap_or(&0);
                row.push(count.to_string());
            }
            result.push(row);
        }

        result
    }
}