impl Solution {
    pub fn min_number_of_hours(initial_energy: i32, initial_experience: i32, energy: Vec<i32>, experience: Vec<i32>) -> i32 {
        let mut energy_needed = 0;
        let mut current_energy = initial_energy;
        let mut current_experience = initial_experience;

        for i in 0..energy.len() {
            if current_energy <= energy[i] {
                energy_needed += energy[i] - current_energy + 1;
                current_energy = energy[i] + 1;
            }
            current_energy -= energy[i];

            if current_experience <= experience[i] {
                energy_needed += experience[i] - current_experience + 1;
                current_experience = experience[i] + 1;
            }
            current_experience += experience[i];
        }

        energy_needed
    }
}