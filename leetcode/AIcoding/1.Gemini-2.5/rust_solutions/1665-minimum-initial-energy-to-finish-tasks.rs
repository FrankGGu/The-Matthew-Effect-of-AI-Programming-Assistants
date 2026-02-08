impl Solution {
    pub fn minimum_initial_energy(mut tasks: Vec<Vec<i32>>) -> i64 {
        tasks.sort_unstable_by(|a, b| {
            let diff_a = a[1] - a[0];
            let diff_b = b[1] - b[0];
            diff_b.cmp(&diff_a)
        });

        let mut ans: i64 = 0;
        let mut current_energy_level: i64 = 0;

        for task in tasks {
            let actual = task[0] as i64;
            let minimum = task[1] as i64;

            if current_energy_level < minimum {
                let deficit = minimum - current_energy_level;
                ans += deficit;
                current_energy_level += deficit;
            }

            current_energy_level -= actual;
        }

        ans
    }
}