impl Solution {
    pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
        use std::collections::{BTreeMap, BTreeSet};

        let mut table_food: BTreeMap<i32, BTreeSet<String>> = BTreeMap::new();
        let mut food_names: BTreeSet<String> = BTreeSet::new();

        for order in orders {
            let table_number = order[1].parse::<i32>().unwrap();
            let food_name = order[2].clone();

            table_food.entry(table_number).or_insert(BTreeSet::new()).insert(food_name.clone());
            food_names.insert(food_name);
        }

        let mut result: Vec<Vec<String>> = Vec::new();

        let mut header: Vec<String> = vec!["Table".to_string()];
        for food in food_names.iter() {
            header.push(food.clone());
        }
        result.push(header);

        for (table_number, foods) in table_food.iter() {
            let mut row: Vec<String> = vec![table_number.to_string()];
            for food_name in food_names.iter() {
                let count = orders.iter().filter(|order| order[1].parse::<i32>().unwrap() == *table_number && order[2] == *food_name).count();
                row.push(count.to_string());
            }
            result.push(row);
        }

        result
    }
}