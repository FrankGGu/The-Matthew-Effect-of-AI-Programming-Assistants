impl Solution {
    pub fn max_satisfaction(mut satisfaction: Vec<i32>) -> i32 {
        satisfaction.sort_unstable();

        let mut current_sum_of_satisfactions = 0;
        let mut current_total_satisfaction = 0;
        let mut max_total_satisfaction = 0;

        for i in (0..satisfaction.len()).rev() {
            let s = satisfaction[i];

            if current_sum_of_satisfactions + s > 0 {
                current_sum_of_satisfactions += s;
                current_total_satisfaction += current_sum_of_satisfactions;
                max_total_satisfaction = max_total_satisfaction.max(current_total_satisfaction);
            } else {
                break;
            }
        }

        max_total_satisfaction
    }
}