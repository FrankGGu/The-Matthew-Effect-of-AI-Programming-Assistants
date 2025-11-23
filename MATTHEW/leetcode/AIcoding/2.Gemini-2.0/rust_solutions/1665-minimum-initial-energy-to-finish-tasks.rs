impl Solution {
    pub fn minimum_initial_energy(tasks: Vec<Vec<i32>>) -> i32 {
        let mut tasks = tasks;
        tasks.sort_by(|a, b| (a[1] - a[0]).cmp(&(b[1] - b[0])));

        let mut energy = 0;
        let mut current_energy = 0;

        for task in tasks {
            if current_energy < task[1] {
                energy += task[1] - current_energy;
                current_energy = task[1];
            }
            current_energy -= task[0];
        }

        energy
    }
}