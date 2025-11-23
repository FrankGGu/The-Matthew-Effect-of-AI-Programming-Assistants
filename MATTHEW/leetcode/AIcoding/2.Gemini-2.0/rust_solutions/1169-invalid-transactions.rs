impl Solution {
    pub fn invalid_transactions(transactions: Vec<String>) -> Vec<String> {
        let mut trans: Vec<(&str, i32, i32, &str)> = Vec::new();
        for t in &transactions {
            let parts: Vec<&str> = t.split(",").collect();
            trans.push((parts[0], parts[1].parse().unwrap(), parts[2].parse().unwrap(), parts[3]));
        }

        let mut invalid: Vec<String> = Vec::new();
        for i in 0..trans.len() {
            let (name1, time1, amount1, city1) = trans[i];
            if amount1 > 1000 {
                invalid.push(transactions[i].clone());
                continue;
            }

            let mut is_invalid = false;
            for j in 0..trans.len() {
                if i == j {
                    continue;
                }
                let (name2, time2, amount2, city2) = trans[j];
                if name1 == name2 && city1 != city2 && (time1 - time2).abs() <= 60 {
                    is_invalid = true;
                    break;
                }
            }

            if is_invalid {
                invalid.push(transactions[i].clone());
            }
        }

        invalid.sort();
        invalid.dedup();
        invalid
    }
}