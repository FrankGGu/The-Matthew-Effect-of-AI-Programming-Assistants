use std::collections::HashMap;

impl Solution {
    pub fn interchangeable_rectangles(rectangles: Vec<Vec<i32>>) -> i64 {
        let mut ratios: HashMap<f64, i64> = HashMap::new();
        let mut count: i64 = 0;

        for rect in rectangles {
            let width = rect[0] as f64;
            let height = rect[1] as f64;
            let ratio = width / height;

            if ratios.contains_key(&ratio) {
                count += ratios[&ratio];
                *ratios.get_mut(&ratio).unwrap() += 1;
            } else {
                ratios.insert(ratio, 1);
            }
        }

        count
    }
}