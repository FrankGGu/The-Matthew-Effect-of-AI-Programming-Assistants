impl Solution {
    pub fn max_total_damage(damage: Vec<i32>, armor: i32) -> i64 {
        let mut sum: i64 = 0;
        let mut max_damage: i32 = 0;

        for &d in &damage {
            sum += d as i64;
            max_damage = max_damage.max(d);
        }

        sum - (max_damage.min(armor) as i64)
    }
}