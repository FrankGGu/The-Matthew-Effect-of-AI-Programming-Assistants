impl Solution {
    pub fn find_min_cost(nums: Vec<i32>, cost: Vec<i32>) -> i64 {
        let mut nums_and_cost: Vec<_> = nums.iter().zip(cost.iter()).collect();
        nums_and_cost.sort_unstable();

        let total_cost: i64 = cost.iter().map(|&x| x as i64).sum();
        let mut current_cost: i64 = 0;
        let mut median = 0;

        for (&num, &c) in nums_and_cost.iter() {
            current_cost += c as i64;
            if current_cost > total_cost / 2 {
                median = *num;
                break;
            }
        }

        nums.iter().zip(cost.iter()).map(|(&num, &c)| (num as i64 - median as i64).abs() * c as i64).sum()
    }
}