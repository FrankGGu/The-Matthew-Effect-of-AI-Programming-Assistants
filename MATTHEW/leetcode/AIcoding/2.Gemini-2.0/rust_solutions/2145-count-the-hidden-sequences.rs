impl Solution {
    pub fn number_of_arrays(n: i32, differences: Vec<i32>, lower: i32, upper: i32) -> i32 {
        let mut min_val = 0;
        let mut max_val = 0;
        let mut current_val = 0;

        for &diff in &differences {
            current_val += diff;
            min_val = min_val.min(current_val);
            max_val = max_val.max(current_val);
        }

        let min_start = lower - min_val;
        let max_start = upper - max_val;

        if min_start > max_start {
            return 0;
        }

        return (max_start - min_start + 1).max(0);
    }
}