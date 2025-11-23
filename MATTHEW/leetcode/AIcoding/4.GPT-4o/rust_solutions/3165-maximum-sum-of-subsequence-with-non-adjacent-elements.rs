impl Solution {
    pub fn max_sum_non_adjacent(nums: Vec<i32>) -> i32 {
        let mut incl = 0;
        let mut excl = 0;

        for &num in &nums {
            let new_excl = excl.max(incl);
            incl = excl + num;
            excl = new_excl;
        }

        incl.max(excl)
    }
}