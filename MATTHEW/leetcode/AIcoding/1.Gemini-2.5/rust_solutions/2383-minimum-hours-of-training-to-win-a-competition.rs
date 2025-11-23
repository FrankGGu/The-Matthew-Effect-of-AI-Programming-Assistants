impl Solution {
    pub fn min_number_of_hours(initial_energy: i32, initial_experience: i32, energy: Vec<i32>, experience: Vec<i32>) -> i32 {
        let mut current_energy = initial_energy;
        let mut current_experience = initial_experience;
        let mut total_training_hours = 0;

        for i in 0..energy.len() {
            let opponent_energy = energy[i];
            let opponent_experience = experience[i];

            // Check and train for energy
            if current_energy <= opponent_energy {
                let needed_energy_training = opponent_energy - current_energy + 1;
                total_training_hours += needed_energy_training;
                current_energy += needed_energy_training;
            }

            // Check and train for experience
            if current_experience <= opponent_experience {
                let needed_experience_training = opponent_experience - current_experience + 1;
                total_training_hours += needed_experience_training;
                current_experience += needed_experience_training;
            }

            // After defeating the opponent
            current_energy -= opponent_energy;
            current_experience += opponent_experience;
        }

        total_training_hours
    }
}