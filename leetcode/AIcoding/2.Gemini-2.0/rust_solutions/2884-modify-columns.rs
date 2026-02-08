use std::collections::HashMap;

use serde_json::Value;

fn modify_columns(items: Vec<HashMap<String, Value>>, columns: HashMap<String, String>) -> Vec<HashMap<String, Value>> {
    items.into_iter().map(|mut item| {
        let mut new_item: HashMap<String, Value> = HashMap::new();
        for (key, value) in item.into_iter() {
            if let Some(new_key) = columns.get(&key) {
                new_item.insert(new_key.clone(), value);
            } else {
                new_item.insert(key, value);
            }
        }
        new_item
    }).collect()
}