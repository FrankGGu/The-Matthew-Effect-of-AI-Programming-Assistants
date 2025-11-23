impl Solution {

use std::cmp::Ordering;

impl Solution {
    pub fn successful_pairs(spells: Vec<i32>, potions: Vec<i32>, success: i32) -> Vec<i32> {
        let mut potions = potions;
        potions.sort();
        let n = potions.len();
        let mut result = Vec::with_capacity(spells.len());

        for &spell in &spells {
            let mut left = 0;
            let mut right = n as i32 - 1;
            let mut idx = n as i32;

            while left <= right {
                let mid = (left + right) / 2;
                match spell * potions[mid as usize] {
                    x if x >= success => {
                        idx = mid;
                        right = mid - 1;
                    }
                    _ => left = mid + 1,
                }
            }

            result.push((n as i32 - idx) as i32);
        }

        result
    }
}
}