use std::collections::HashMap;

impl Solution {
    pub fn interchangeable_rectangles(rectangles: Vec<Vec<i32>>) -> i64 {
        let mut ratio_counts = HashMap::new();
        let mut res = 0;

        for rect in rectangles {
            let w = rect[0] as i64;
            let h = rect[1] as i64;
            let gcd_val = gcd(w, h);
            let simplified = (w / gcd_val, h / gcd_val);
            let count = ratio_counts.entry(simplified).or_insert(0);
            res += *count;
            *count += 1;
        }

        res
    }
}

fn gcd(a: i64, b: i64) -> i64 {
    if b == 0 {
        a
    } else {
        gcd(b, a % b)
    }
}