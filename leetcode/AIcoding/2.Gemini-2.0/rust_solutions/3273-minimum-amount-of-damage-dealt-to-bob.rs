impl Solution {
    pub fn min_damage(damage: Vec<i32>, armor: i32) -> i32 {
        let mut max_damage = 0;
        let mut sum_damage = 0;

        for &d in &damage {
            max_damage = max_damage.max(d);
            sum_damage += d;
        }

        let armor_used = max_damage.min(armor);
        sum_damage - armor_used
    }
}