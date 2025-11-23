use std::collections::HashMap;

impl Solution {
    pub fn right_triangles(triangles: Vec<Vec<i32>>) -> i32 {
        let mut x_count: HashMap<i32, i32> = HashMap::new();
        let mut y_count: HashMap<i32, i32> = HashMap::new();

        for triangle in &triangles {
            let x = triangle[0];
            let y = triangle[1];

            *x_count.entry(x).or_insert(0) += 1;
            *y_count.entry(y).or_insert(0) += 1;
        }

        let mut result = 0;
        for triangle in &triangles {
            let x = triangle[0];
            let y = triangle[1];

            let x_val = x_count.get(&x).unwrap_or(&0);
            let y_val = y_count.get(&y).unwrap_or(&0);

            result += (x_val - 1) * (y_val - 1);
        }

        result
    }
}

struct Solution;