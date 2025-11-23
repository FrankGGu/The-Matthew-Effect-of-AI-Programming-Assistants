impl Solution {
    pub fn successful_pairs(spells: Vec<i32>, mut potions: Vec<i32>, success: i64) -> Vec<i32> {
        potions.sort_unstable();
        let n = spells.len();
        let m = potions.len();
        let mut results = Vec::with_capacity(n);

        for &spell in spells.iter() {
            // Calculate the minimum potion value required for a successful pair.
            // spell * potion >= success
            // potion >= success / spell
            // Using integer division for ceiling: (a + b - 1) / b
            let min_required_potion_val_i64 = (success + spell as i64 - 1) / (spell as i64);

            // Find the index of the first potion that is greater than or equal to min_required_potion_val_i64.
            // This is equivalent to a lower_bound operation.
            let idx = match potions.binary_search_by(|&p| (p as i64).cmp(&min_required_potion_val_i64)) {
                Ok(i) => i,
                Err(i) => i,
            };

            // The number of successful potions is the count of potions from idx to the end of the array.
            results.push((m - idx) as i32);
        }

        results
    }
}