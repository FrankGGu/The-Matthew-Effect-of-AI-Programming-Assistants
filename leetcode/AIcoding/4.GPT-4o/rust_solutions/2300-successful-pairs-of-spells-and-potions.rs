use std::cmp::Ordering;

pub fn successful_pairs(spells: Vec<i32>, potions: Vec<i32>, success: i64) -> Vec<i32> {
    let mut potions = potions;
    potions.sort();

    spells.iter().map(|&spell| {
        let target = (success as f64 / spell as f64).ceil() as i32;
        match potions.binary_search(&target) {
            Ok(pos) | Err(pos) => (potions.len() - pos) as i32,
        }
    }).collect()
}