struct Solution;

impl Solution {
    pub fn volunteer_allocation(nums: Vec<i32>, k: i64) -> i32 {
        let n = nums.len() as i64;
        let modulo: i64 = 1_000_000_007;

        let mut sum_nums: i64 = 0;
        for &num in &nums {
            sum_nums += num as i64;
        }

        let total_extra_volunteers = k - sum_nums;

        let q = total_extra_volunteers / n; // Base number of extra volunteers for each task
        let r = total_extra_volunteers % n; // Number of tasks that receive one additional extra volunteer

        let mut sorted_nums = nums.iter().map(|&x| x as i64).collect::<Vec<i64>>();
        sorted_nums.sort_unstable(); // Sort nums to ensure smaller base values get the additional extra volunteer first

        let mut ans: i64 = 1;

        for i in 0..n {
            let mut current_task_volunteers = sorted_nums[i as usize] + q;
            if i < r {
                // The first 'r' tasks (those with the smallest original nums[i] values after sorting)
                // receive one additional extra volunteer.
                current_task_volunteers += 1;
            }
            ans = (ans * (current_task_volunteers % modulo)) % modulo;
        }

        ans as i32
    }
}