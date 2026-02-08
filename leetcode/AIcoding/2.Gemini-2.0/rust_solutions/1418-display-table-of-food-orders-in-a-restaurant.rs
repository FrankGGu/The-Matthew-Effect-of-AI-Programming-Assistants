use std::collections::{BTreeMap, BTreeSet};

impl Solution {
    pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut food_items: BTreeSet<String> = BTreeSet::new();
        let mut table_orders: BTreeMap<i32, BTreeMap<String, i32>> = BTreeMap::new();

        for order in &orders {
            let table_number: i32 = order[1].parse().unwrap();
            let food_item = order[2].clone();

            food_items.insert(food_item.clone());

            table_orders.entry(table_number)
                .or_insert(BTreeMap::new())
                .entry(food_item)
                .and_modify(|count| *count += 1)
                .or_insert(1);
        }

        let mut result: Vec<Vec<String>> = Vec::new();
        let mut header: Vec<String> = vec!["Table".to_string()];
        for food_item in &food_items {
            header.push(food_item.clone());
        }
        result.push(header);

        for (table_number, order_counts) in &table_orders {
            let mut row: Vec<String> = vec![table_number.to_string()];
            for food_item in &food_items {
                let count = order_counts.get(food_item).unwrap_or(&0);
                row.push(count.to_string());
            }
            result.push(row);
        }

        result
    }
}