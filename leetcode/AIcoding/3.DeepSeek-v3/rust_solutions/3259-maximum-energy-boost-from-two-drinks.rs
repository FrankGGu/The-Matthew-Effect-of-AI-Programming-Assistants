use std::collections::HashMap;

impl Solution {
    pub fn maximum_energy(energy: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = energy.len();
        let mut dp = HashMap::new();
        let mut max_energy = i32::MIN;

        for i in (0..n).rev() {
            let next = i + k;
            let val = energy[i] + if next < n { *dp.get(&next).unwrap() } else { 0 };
            dp.insert(i, val);
            max_energy = max_energy.max(val);
        }

        max_energy
    }
}