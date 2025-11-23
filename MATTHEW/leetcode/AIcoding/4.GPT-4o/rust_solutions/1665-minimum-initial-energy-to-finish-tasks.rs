impl Solution {
    pub fn minimum_effort(tasks: Vec<Vec<i32>>) -> i32 {
        let mut tasks = tasks;
        tasks.sort_by(|a, b| (a[1] - a[0]).cmp(&(b[1] - b[0])));

        let mut total_energy = 0;
        let mut current_energy = 0;

        for task in tasks.iter() {
            let (actual, required) = (task[0], task[1]);
            if current_energy < required {
                total_energy += required - current_energy;
                current_energy = required;
            }
            current_energy -= actual;
        }

        total_energy
    }
}