impl Solution {
    pub fn minimum_increment_operations(nums: Vec<i32>, target: i32) -> i64 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }

        let mut arr: Vec<i64> = nums.into_iter().map(|x| x as i64).collect();
        let target_i64 = target as i64;
        let mut total_cost: i64 = 0;

        for i in 2..n {
            let current_sum = arr[i - 2] + arr[i - 1] + arr[i];
            if current_sum < target_i64 {
                let diff = target_i64 - current_sum;
                arr[i] += diff;
                total_cost += diff;
            }
        }

        total_cost
    }
}