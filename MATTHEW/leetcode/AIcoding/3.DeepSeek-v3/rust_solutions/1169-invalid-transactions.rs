use std::collections::HashMap;

#[derive(Debug)]
struct Transaction {
    name: String,
    time: i32,
    amount: i32,
    city: String,
    original: String,
}

impl Solution {
    pub fn invalid_transactions(transactions: Vec<String>) -> Vec<String> {
        let mut map: HashMap<String, Vec<Transaction>> = HashMap::new();
        let mut invalid = Vec::new();

        for s in &transactions {
            let parts: Vec<&str> = s.split(',').collect();
            let name = parts[0].to_string();
            let time = parts[1].parse::<i32>().unwrap();
            let amount = parts[2].parse::<i32>().unwrap();
            let city = parts[3].to_string();
            let transaction = Transaction {
                name: name.clone(),
                time,
                amount,
                city: city.clone(),
                original: s.clone(),
            };
            map.entry(name).or_default().push(transaction);
        }

        for s in &transactions {
            let parts: Vec<&str> = s.split(',').collect();
            let name = parts[0];
            let time = parts[1].parse::<i32>().unwrap();
            let amount = parts[2].parse::<i32>().unwrap();
            let city = parts[3];

            if amount > 1000 {
                invalid.push(s.clone());
                continue;
            }

            if let Some(list) = map.get(name) {
                for t in list {
                    if t.city != city && (t.time - time).abs() <= 60 {
                        invalid.push(s.clone());
                        break;
                    }
                }
            }
        }

        invalid
    }
}