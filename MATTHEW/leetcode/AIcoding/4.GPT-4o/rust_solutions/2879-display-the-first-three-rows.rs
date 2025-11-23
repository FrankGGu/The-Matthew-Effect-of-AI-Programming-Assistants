use std::collections::HashMap;

pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut food_items = HashMap::new();
    let mut tables = HashMap::new();

    for order in orders {
        let table: String = order[1].clone();
        let food: String = order[2].clone();

        *tables.entry(table.clone()).or_insert(0) += 1;
        *food_items.entry(food).or_insert(0) += 1;
    }

    let mut food_list: Vec<String> = food_items.keys().cloned().collect();
    food_list.sort();

    let mut result = vec![vec!["Table".to_string()].into_iter().chain(food_list).collect()];

    let mut table_list: Vec<(String, usize)> = tables.into_iter().collect();
    table_list.sort_by_key(|(table, _)| table.clone());

    for (table, _) in table_list {
        let mut row = vec![table];
        for food in &food_list {
            row.push(if let Some(&count) = food_items.get(food) {
                count.to_string()
            } else {
                "0".to_string()
            });
        }
        result.push(row);
    }

    result
}