impl Solution {
    pub fn min_number_of_hours(initial_energy: i32, initial_experience: i32, energy: Vec<i32>, experience: Vec<i32>) -> i32 {
        let mut total_energy = energy.iter().sum::<i32>();
        let mut required_energy = if initial_energy > total_energy { 0 } else { total_energy - initial_energy + 1 };

        let mut current_exp = initial_experience;
        let mut required_exp = 0;

        for &exp in experience.iter() {
            if current_exp <= exp {
                let needed = exp - current_exp + 1;
                required_exp += needed;
                current_exp += needed;
            }
            current_exp += exp;
        }

        required_energy + required_exp
    }
}