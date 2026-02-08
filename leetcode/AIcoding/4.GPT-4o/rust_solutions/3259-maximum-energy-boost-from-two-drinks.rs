impl Solution {
    pub fn max_energy(drinks: Vec<Vec<i32>>) -> i32 {
        let n = drinks.len();
        let mut total_energy = vec![0; n];
        let mut max_boost = vec![0; n];

        for i in 0..n {
            total_energy[i] = drinks[i][0];
            max_boost[i] = drinks[i][1];
        }

        let mut max_energy = 0;
        for i in 0..n {
            for j in i + 1..n {
                max_energy = max_energy.max(total_energy[i] + total_energy[j] + max_boost[i] + max_boost[j]);
            }
        }

        max_energy
    }
}