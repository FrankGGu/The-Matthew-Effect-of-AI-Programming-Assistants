impl Solution {
    pub fn minimum_cost(gains: Vec<i32>, losses: Vec<i32>) -> i32 {
        let mut total_gain = 0;
        let mut total_loss = 0;

        for &gain in &gains {
            total_gain += gain;
        }

        for &loss in &losses {
            total_loss += loss;
        }

        total_loss - total_gain
    }
}