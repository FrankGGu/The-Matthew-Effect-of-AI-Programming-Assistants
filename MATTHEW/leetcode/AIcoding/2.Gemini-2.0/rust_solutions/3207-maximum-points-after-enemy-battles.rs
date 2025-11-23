impl Solution {
    pub fn max_points(enemies: Vec<i32>, armor: i32, power: i32) -> i64 {
        let mut sum = 0;
        let mut max_enemy = 0;
        for &enemy in &enemies {
            sum += enemy as i64;
            max_enemy = max_enemy.max(enemy);
        }

        let armor_used = max_enemy.min(armor);

        sum - (max_enemy - armor_used) as i64
    }
}