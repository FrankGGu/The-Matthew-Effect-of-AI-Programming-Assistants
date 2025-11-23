impl Solution {
    pub fn max_satisfaction(satisfaction: Vec<i32>) -> i32 {
        let mut satisfaction = satisfaction;
        satisfaction.sort();
        let n = satisfaction.len();
        let mut max_sum = 0;
        let mut sum = 0;
        let mut total = 0;

        for i in (0..n).rev() {
            sum += satisfaction[i];
            total += sum;
            if total > max_sum {
                max_sum = total;
            }
        }

        max_sum
    }
}