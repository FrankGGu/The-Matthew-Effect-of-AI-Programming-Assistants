struct Solution;

impl Solution {
    pub fn count_rectangles(rectangles: Vec<Vec<i32>>, points: Vec<Vec<i32>>) -> Vec<i32> {
        use std::collections::HashMap;

        let mut x_to_y = HashMap::new();

        for rect in &rectangles {
            let x1 = rect[0];
            let y1 = rect[1];
            let x2 = rect[2];
            let y2 = rect[3];

            for x in x1..=x2 {
                x_to_y.entry(x).or_insert_with(Vec::new).push(y1);
                x_to_y.entry(x).or_insert_with(Vec::new).push(y2);
            }
        }

        for (_, ys) in &mut x_to_y {
            ys.sort();
        }

        let mut result = Vec::new();

        for point in &points {
            let x = point[0];
            let y = point[1];

            let mut count = 0;

            if let Some(ys) = x_to_y.get(&x) {
                for &y_val in ys {
                    if y_val >= y {
                        count += 1;
                    }
                }
            }

            result.push(count);
        }

        result
    }
}