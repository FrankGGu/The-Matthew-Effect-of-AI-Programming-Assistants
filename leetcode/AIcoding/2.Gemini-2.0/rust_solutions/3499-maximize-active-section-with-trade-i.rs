impl Solution {
    pub fn maximize_active_section(charges: Vec<i32>, k: i32) -> i32 {
        let n = charges.len();
        let mut max_active = 0;
        let mut current_active = 0;

        for i in 0..k as usize {
            current_active += charges[i];
        }
        max_active = current_active;

        for i in k as usize..n {
            current_active += charges[i] - charges[i - k as usize];
            max_active = max_active.max(current_active);
        }

        max_active
    }
}