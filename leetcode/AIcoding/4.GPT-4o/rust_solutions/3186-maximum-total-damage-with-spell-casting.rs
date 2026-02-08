impl Solution {
    pub fn maximum_damage(spells: Vec<i32>, potions: Vec<i32>, success: i32) -> i64 {
        let mut total_damage = 0;
        let mut max_damage = 0;

        for &spell in &spells {
            let damage = spell as i64;
            total_damage += damage;
            max_damage = max_damage.max(damage);
        }

        let mut max_potion_effect = 0;
        for &potion in &potions {
            max_potion_effect = max_potion_effect.max(potion);
        }

        total_damage + ((max_damage * (success as i64)) / 100) * max_potion_effect as i64
    }
}