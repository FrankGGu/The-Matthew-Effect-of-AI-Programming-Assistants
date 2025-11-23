use std::collections::HashMap;

pub fn invalid_transactions(transactions: Vec<String>) -> Vec<String> {
    let mut invalid = vec![];
    let mut records: HashMap<String, Vec<(i32, &str)>> = HashMap::new();

    for transaction in &transactions {
        let parts: Vec<&str> = transaction.split(',').collect();
        let name = parts[0];
        let time: i32 = parts[1].parse().unwrap();
        let amount: i32 = parts[2].parse().unwrap();
        let city = parts[3];

        if amount > 1000 {
            invalid.push(transaction.clone());
        }

        records.entry(name.to_string()).or_default().push((time, city));
    }

    for (name, trans) in records {
        let n = trans.len();
        for i in 0..n {
            let (time_i, city_i) = trans[i];
            for j in 0..n {
                if i != j {
                    let (time_j, city_j) = trans[j];
                    if (time_i - time_j).abs() <= 60 && city_i != city_j {
                        invalid.push(transactions.iter().find(|&t| t.starts_with(&format!("{}," , name))).unwrap().to_string());
                        break;
                    }
                }
            }
        }
    }

    invalid.sort();
    invalid.dedup();
    invalid
}