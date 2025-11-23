impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn max_total_damage(heroes: Vec<i32>) -> i32 {
        let mut damage_count = HashMap::new();
        for &hero in &heroes {
            *damage_count.entry(hero).or_insert(0) += 1;
        }

        let mut sorted_damages: Vec<i32> = damage_count.keys().cloned().collect();
        sorted_damages.sort();

        let mut dp = HashMap::new();
        for &dmg in &sorted_damages {
            let mut max_damage = dmg * damage_count[&dmg];
            for &prev_dmg in &sorted_damages {
                if prev_dmg < dmg - 1 {
                    max_damage = std::cmp::max(max_damage, dmg * damage_count[&dmg] + *dp.get(&prev_dmg).unwrap_or(&0));
                }
            }
            dp.insert(dmg, max_damage);
        }

        *dp.values().max().unwrap()
    }
}
}