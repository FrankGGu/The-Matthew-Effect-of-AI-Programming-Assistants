use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut food_items_set: HashSet<String> = HashSet::new();
        let mut table_data: HashMap<i32, HashMap<String, i32>> = HashMap::new();

        for order in orders {
            let table_number_str = &order[1];
            let food_item = &order[2];

            food_items_set.insert(food_item.clone());

            let table_num = table_number_str.parse::<i32>().unwrap();
            *table_data
                .entry(table_num)
                .or_default()
                .entry(food_item.clone())
                .or_insert(0) += 1;
        }

        let mut sorted_food_items: Vec<String> = food_items_set.into_iter().collect();
        sorted_food_items.sort_unstable();

        let mut result: Vec<Vec<String>> = Vec::new();

        let mut header_row: Vec<String> = Vec::new();
        header_row.push("Table".to_string());
        for item in &sorted_food_items {
            header_row.push(item.clone());
        }
        result.push(header_row);

        let mut sorted_table_numbers: Vec<i32> = table_data.keys().cloned().collect();
        sorted_table_numbers.sort_unstable();

        for table_num in sorted_table_numbers {
            let mut data_row: Vec<String> = Vec::new();
            data_row.push(table_num.to_string());

            let table_orders = table_data.get(&table_num).unwrap();

            for food_item in &sorted_food_items {
                let count = table_orders.get(food_item).unwrap_or(&0);
                data_row.push(count.to_string());
            }
            result.push(data_row);
        }

        result
    }
}