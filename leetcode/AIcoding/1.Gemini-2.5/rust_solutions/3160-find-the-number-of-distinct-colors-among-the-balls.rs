use std::collections::HashMap;

impl Solution {
    pub fn find_distinct_colors(mut colors: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut color_counts: HashMap<i32, i32> = HashMap::new();
        for &color in &colors {
            *color_counts.entry(color).or_insert(0) += 1;
        }

        let mut result: Vec<i32> = Vec::with_capacity(queries.len());

        for query in queries {
            let ball_idx = query[0] as usize;
            let new_color = query[1];

            let old_color = colors[ball_idx];

            if let Some(count) = color_counts.get_mut(&old_color) {
                *count -= 1;
                if *count == 0 {
                    color_counts.remove(&old_color);
                }
            }

            colors[ball_idx] = new_color;

            *color_counts.entry(new_color).or_insert(0) += 1;

            result.push(color_counts.len() as i32);
        }

        result
    }
}