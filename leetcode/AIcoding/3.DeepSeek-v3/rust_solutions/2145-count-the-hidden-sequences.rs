impl Solution {
    pub fn number_of_arrays(differences: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let mut min_val = 0;
        let mut max_val = 0;
        let mut current = 0;

        for &diff in &differences {
            current += diff;
            min_val = min_val.min(current);
            max_val = max_val.max(current);
        }

        let total = (upper - lower) - (max_val - min_val) + 1;
        if total > 0 {
            total
        } else {
            0
        }
    }
}