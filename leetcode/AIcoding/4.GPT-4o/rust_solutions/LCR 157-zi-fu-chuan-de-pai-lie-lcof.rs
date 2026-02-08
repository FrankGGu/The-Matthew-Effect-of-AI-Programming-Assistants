pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
    use std::collections::HashMap;

    let mut table_items = HashMap::new();
    let mut tables = Vec::new();

    for order in orders {
        let table_number: String = order[1].clone();
        let food_item: String = order[2].clone();

        if !tables.contains(&table_number) {
            tables.push(table_number.clone());
        }

        let entry = table_items.entry((table_number, food_item)).or_insert(0);
        *entry += 1;
    }

    tables.sort();

    let mut result = vec![vec!["Table".to_string()]];
    result[0].extend(table_items.values().map(|(k, _)| k.clone()).collect::<Vec<String>>());

    let mut food_items: Vec<String> = table_items.keys().map(|(_, item)| item.clone()).collect();
    food_items.sort();

    for food in food_items {
        let mut row = vec![food.clone()];
        for table in &tables {
            let count = table_items.get(&(table.clone(), food.clone())).unwrap_or(&0);
            row.push(count.to_string());
        }
        result.push(row);
    }

    result
}