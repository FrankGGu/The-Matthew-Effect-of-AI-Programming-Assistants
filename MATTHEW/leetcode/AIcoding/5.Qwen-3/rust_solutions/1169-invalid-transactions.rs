impl Solution {

use std::collections::{HashSet, HashMap};

struct Solution;

impl Solution {
    pub fn invalid_transactions(mut transactions: Vec<String>) -> Vec<String> {
        let mut parsed = Vec::new();
        for t in &transactions {
            let parts: Vec<&str> = t.split(',').collect();
            let name = parts[0];
            let time = parts[1].parse::<i32>().unwrap();
            let amount = parts[2].parse::<i32>().unwrap();
            let city = parts[3];
            parsed.push((name, time, amount, city, t));
        }

        let mut result = Vec::new();
        let mut name_map = HashMap::new();

        for (name, time, amount, city, original) in &parsed {
            if amount > 1000 {
                result.push(original.to_string());
                continue;
            }

            let mut found = false;
            for (other_name, other_time, other_amount, other_city, other_original) in &parsed {
                if name == other_name && city != *other_city && (time - other_time).abs() <= 60 {
                    found = true;
                    break;
                }
            }

            if found {
                result.push(original.to_string());
            }
        }

        result
    }
}
}