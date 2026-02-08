use std::collections::HashMap;

impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn interchangeable_rectangles(rectangles: Vec<Vec<i32>>) -> i64 {
        let mut counts: HashMap<(i32, i32), i32> = HashMap::new();
        let mut total_pairs: i64 = 0;

        for rect in rectangles {
            let w = rect[0];
            let h = rect[1];
            let common_divisor = Self::gcd(w, h);
            let simplified_w = w / common_divisor;
            let simplified_h = h / common_divisor;
            *counts.entry((simplified_w, simplified_h)).or_insert(0) += 1;
        }

        for count in counts.values() {
            if *count >= 2 {
                total_pairs += (*count as i64) * ((*count as i64) - 1) / 2;
            }
        }

        total_pairs
    }
}