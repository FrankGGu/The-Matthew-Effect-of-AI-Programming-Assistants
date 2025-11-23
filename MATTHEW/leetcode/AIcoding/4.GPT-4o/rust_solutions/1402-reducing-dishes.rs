impl Solution {
    pub fn max_satisfaction(satisfaction: Vec<i32>) -> i32 {
        let mut satisfaction = satisfaction;
        satisfaction.sort_unstable();
        let n = satisfaction.len();
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut total = 0;

        for i in (0..n).rev() {
            current_sum += satisfaction[i];
            total += current_sum;
            max_sum = max_sum.max(total);
        }

        max_sum
    }
}