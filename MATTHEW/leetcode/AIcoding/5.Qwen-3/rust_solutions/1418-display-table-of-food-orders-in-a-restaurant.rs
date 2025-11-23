impl Solution {

use std::collections::{HashMap, BTreeSet};

impl Solution {
    pub fn display_table(orders: Vec<Vec<String>>) -> Vec<Vec<String>> {
        let mut foods = BTreeSet::new();
        let mut tables = BTreeSet::new();
        let mut table_foods = HashMap::new();

        for order in &orders {
            let table = &order[1];
            let food = &order[2];
            tables.insert(table);
            foods.insert(food);
            let entry = table_foods.entry(table).or_insert(HashMap::new());
            *entry.entry(food).or_insert(0) += 1;
        }

        let mut result = vec![vec!["Table".to_string()]];
        result[0].extend(foods.iter().map(|f| f.to_string()));

        for table in tables {
            let mut row = vec![table.clone()];
            for food in &foods {
                let count = table_foods.get(table).and_then(|f| f.get(food)).copied().unwrap_or(0);
                row.push(count.to_string());
            }
            result.push(row);
        }

        result
    }
}
}