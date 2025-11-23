use std::collections::HashMap;

impl Solution {
    pub fn max_equal_rows_after_flipping(matrix: Vec<Vec<i32>>) -> i32 {
        let mut counts: HashMap<String, i32> = HashMap::new();
        for row in &matrix {
            let mut s1 = String::new();
            let mut s2 = String::new();
            for &x in row {
                s1.push_str(&x.to_string());
                s2.push_str(&(1 - x).to_string());
            }
            let key = if row[0] == 0 { s1 } else { s2 };
            *counts.entry(key).or_insert(0) += 1;
        }
        *counts.values().max().unwrap_or(&0)
    }
}