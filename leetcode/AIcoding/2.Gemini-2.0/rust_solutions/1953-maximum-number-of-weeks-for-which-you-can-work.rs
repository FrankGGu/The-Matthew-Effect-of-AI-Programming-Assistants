impl Solution {
    pub fn number_of_weeks(milestones: Vec<i32>) -> i64 {
        let mut max_val = 0;
        let mut sum = 0;
        for &x in &milestones {
            sum += x as i64;
            max_val = max_val.max(x as i64);
        }

        let other_sum = sum - max_val;

        if max_val > other_sum {
            return 2 * other_sum + 1;
        } else {
            return sum;
        }
    }
}