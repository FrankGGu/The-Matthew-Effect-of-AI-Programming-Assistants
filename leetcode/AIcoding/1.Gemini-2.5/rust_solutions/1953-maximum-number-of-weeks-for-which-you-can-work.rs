impl Solution {
    pub fn number_of_weeks(milestones: Vec<i32>) -> i64 {
        let max_tasks: i64 = *milestones.iter().max().unwrap() as i64;
        let total_tasks: i64 = milestones.iter().map(|&x| x as i64).sum();

        let remaining_tasks_sum = total_tasks - max_tasks;

        if max_tasks <= remaining_tasks_sum + 1 {
            total_tasks
        } else {
            2 * remaining_tasks_sum + 1
        }
    }
}