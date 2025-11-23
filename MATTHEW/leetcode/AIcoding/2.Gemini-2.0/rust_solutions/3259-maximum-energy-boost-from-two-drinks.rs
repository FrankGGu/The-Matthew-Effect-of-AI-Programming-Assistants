impl Solution {
    pub fn max_energy_boost(drinks: Vec<i32>) -> i32 {
        let mut drinks = drinks;
        drinks.sort();
        drinks[drinks.len() - 1] + drinks[drinks.len() - 2]
    }
}