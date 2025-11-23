impl Solution {
    pub fn max_satisfaction(mut satisfaction: Vec<i32>) -> i32 {
        satisfaction.sort();
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut prefix_sum = 0;
        for i in (0..satisfaction.len()).rev() {
            prefix_sum += satisfaction[i];
            current_sum += prefix_sum;
            max_sum = max_sum.max(current_sum);
        }
        max_sum
    }
}