impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn minimum_perimeter(mut required_apples: i32) -> i32 {
        let mut perimeter = 0;
        let mut apples = 0;
        let mut radius = 1;

        while apples < required_apples {
            let area = (radius * 2 + 1) * (radius * 2 + 1);
            let total_apples = (area - 1) / 2;
            apples += total_apples;
            perimeter = radius * 8;
            radius += 1;
        }

        perimeter
    }
}
}