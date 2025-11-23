use std::collections::HashMap;

impl Solution {
    pub fn odd_and_even_transactions(transactions: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut map: HashMap<(i32, i32), (i32, i32, i32)> = HashMap::new();

        for t in transactions {
            let (id, amount, day) = (t[0], t[1], t[2]);
            let entry = map.entry((id, day)).or_insert((0, 0, 0));
            entry.0 += amount;
            entry.1 += 1;
            entry.2 = day;
        }

        let mut result = Vec::new();

        for ((id, day), (total_amount, count, _)) in map {
            if (total_amount > 2000 && count >= 3) || (day % 2 == 1 && total_amount > 2000) || (day % 2 == 0 && total_amount <= 2000) {
                result.push(vec![id, day]);
            }
        }

        result.sort_by(|a, b| {
            if a[0] == b[0] {
                a[1].cmp(&b[1])
            } else {
                a[0].cmp(&b[0])
            }
        });

        result
    }
}