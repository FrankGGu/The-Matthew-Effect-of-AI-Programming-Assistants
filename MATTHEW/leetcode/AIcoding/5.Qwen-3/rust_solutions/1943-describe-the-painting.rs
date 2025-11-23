impl Solution {

use std::collections::{BTreeMap, HashMap};

impl Solution {
    pub fn describe_painting(mut paintings: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut events = BTreeMap::new();

        for p in &paintings {
            let start = p[0];
            let end = p[1];
            let color = p[2];

            *events.entry(start).or_insert_with(HashMap::new).entry(color).or_insert(0) += 1;
            *events.entry(end).or_insert_with(HashMap::new).entry(color).or_insert(0) -= 1;
        }

        let mut result = Vec::new();
        let mut prev = 0;
        let mut current_colors = HashMap::new();

        for (pos, delta) in events {
            if prev != 0 && prev != pos {
                let mut colors = Vec::new();
                for (color, count) in &current_colors {
                    if *count > 0 {
                        colors.push(*color);
                    }
                }
                colors.sort();
                let mut row = Vec::new();
                row.push(prev);
                row.push(pos);
                row.push(colors.iter().map(|&c| c as i32).sum());
                result.push(row);
            }

            for (color, delta) in delta {
                *current_colors.entry(color).or_insert(0) += delta;
            }

            prev = pos;
        }

        result
    }
}
}