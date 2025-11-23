impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn interchangeable_rectangles(rectangles: Vec<Vec<i32>>) -> i64 {
        let mut ratio_map = HashMap::new();
        let mut result = 0;

        for rect in rectangles {
            let (w, h) = (rect[0], rect[1]);
            let gcd = gcd(w, h);
            let key = (w / gcd, h / gcd);
            *ratio_map.entry(key).or_insert(0) += 1;
        }

        for count in ratio_map.values() {
            if *count >= 2 {
                result += (count as i64) * (count as i64 - 1) / 2;
            }
        }

        result
    }
}

fn gcd(mut a: i32, mut b: i32) -> i32 {
    while b != 0 {
        let temp = b;
        b = a % b;
        a = temp;
    }
    a
}

struct Solution {}
}