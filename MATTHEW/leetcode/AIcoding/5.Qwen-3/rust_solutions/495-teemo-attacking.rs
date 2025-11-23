struct Solution;

impl Solution {
    pub fn teemo_attacking(attack_damage: i32, attack_radius: i32) -> i32 {
        if attack_radius == 0 {
            return 0;
        }
        let duration = attack_radius * 2;
        let mut total = 0;
        let mut time = 0;
        while time < attack_damage {
            total += duration;
            time += 1;
        }
        total
    }
}