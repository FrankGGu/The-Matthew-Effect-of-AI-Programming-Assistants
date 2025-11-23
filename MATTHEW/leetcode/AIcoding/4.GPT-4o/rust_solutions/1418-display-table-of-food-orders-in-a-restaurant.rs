use std::collections::{HashMap, BTreeMap};

pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut table_orders: HashMap<String, HashMap<String, i32>> = HashMap::new();
    let mut food_items = BTreeMap::new();

    for order in orders {
        let table = &order[1];
        let food = &order[2];
        *food_items.entry(food.clone()).or_insert(0) += 1;
        let table_map = table_orders.entry(table.clone()).or_insert(HashMap::new());
        *table_map.entry(food.clone()).or_insert(0) += 1;
    }

    let mut result = vec![vec!["Table".to_string()].into_iter().chain(food_items.keys().cloned()).collect::<Vec<String>>()];

    for (table, foods) in table_orders.iter() {
        let mut row = vec![table.clone()];
        for food in food_items.keys() {
            row.push(foods.get(food).map_or(0, |&count| count).to_string());
        }
        result.push(row);
    }

    result
}