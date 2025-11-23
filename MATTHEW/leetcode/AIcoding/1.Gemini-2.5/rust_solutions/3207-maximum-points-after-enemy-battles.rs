impl Solution {
    pub fn maximum_points(mut enemy_energies: Vec<i32>, current_energy_initial: i32) -> i64 {
        enemy_energies.sort_unstable();

        let n = enemy_energies.len();
        if n == 0 {
            return 0;
        }

        let mut current_energy: i64 = current_energy_initial as i64;
        let mut current_points: i64 = 0;
        let mut left = 0;
        let mut right = n - 1;

        while left <= right {
            if current_energy >= enemy_energies[left] as i64 {
                current_energy -= enemy_energies[left] as i64;
                current_points += 1;
                left += 1;
            } else if current_points > 0 && left < right { // Only sacrifice if we have points AND there's a stronger enemy to gain from
                current_energy += enemy_energies[right] as i64;
                current_points -= 1;
                right -= 1;
            } else {
                break;
            }
        }

        current_points
    }
}