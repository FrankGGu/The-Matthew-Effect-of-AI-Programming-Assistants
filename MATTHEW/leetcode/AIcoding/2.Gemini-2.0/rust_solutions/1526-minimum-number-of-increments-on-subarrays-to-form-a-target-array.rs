impl Solution {
    pub fn min_number_of_increments(target: Vec<i32>) -> i32 {
        let mut res = target[0];
        for i in 1..target.len() {
            res += std::cmp::max(0, target[i] - target[i - 1]);
        }
        res
    }
}