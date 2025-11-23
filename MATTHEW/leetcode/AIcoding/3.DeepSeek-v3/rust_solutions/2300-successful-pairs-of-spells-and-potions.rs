impl Solution {
    pub fn successful_pairs(spells: Vec<i32>, potions: Vec<i32>, success: i64) -> Vec<i32> {
        let mut potions = potions;
        potions.sort_unstable();
        let n = potions.len();
        spells
            .into_iter()
            .map(|s| {
                let min_potion = (success as f64 / s as f64).ceil() as i64;
                let idx = potions.partition_point(|&x| (x as i64) < min_potion);
                (n - idx) as i32
            })
            .collect()
    }
}