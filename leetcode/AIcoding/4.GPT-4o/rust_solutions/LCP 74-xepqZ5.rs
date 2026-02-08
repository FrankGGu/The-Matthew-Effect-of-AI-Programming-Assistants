impl Solution {
    pub fn strongest_spell(f: Vec<i32>, b: Vec<i32>, k: i32) -> i32 {
        let n = f.len();
        let mut max_strength = 0;
        let mut current_strength = 0;

        for i in 0..n {
            current_strength += f[i] - (if i >= k as usize { b[i - k as usize] } else { 0 });
            max_strength = max_strength.max(current_strength);
        }

        max_strength
    }
}