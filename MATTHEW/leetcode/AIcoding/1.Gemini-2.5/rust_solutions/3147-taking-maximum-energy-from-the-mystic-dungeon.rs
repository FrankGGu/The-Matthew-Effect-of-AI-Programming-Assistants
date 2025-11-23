impl Solution {
    pub fn maximum_energy(mut energy: Vec<i32>, k: i32) -> i32 {
        let n = energy.len();
        let k = k as usize;

        for i in (0..n).rev() {
            if i + k < n {
                energy[i] += std::cmp::max(0, energy[i + k]);
            }
        }

        *energy.iter().max().unwrap()
    }
}