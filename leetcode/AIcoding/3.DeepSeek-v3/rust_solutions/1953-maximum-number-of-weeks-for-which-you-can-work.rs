impl Solution {
    pub fn number_of_weeks(milestones: Vec<i32>) -> i64 {
        let max = *milestones.iter().max().unwrap() as i64;
        let sum = milestones.iter().map(|&x| x as i64).sum::<i64>();

        if max <= sum - max + 1 {
            sum
        } else {
            2 * (sum - max) + 1
        }
    }
}