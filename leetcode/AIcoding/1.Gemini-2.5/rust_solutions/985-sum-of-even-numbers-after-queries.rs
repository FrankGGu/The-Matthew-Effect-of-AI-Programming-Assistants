impl Solution {
    pub fn sum_even_after_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = nums;
        let mut current_even_sum: i32 = nums.iter().filter(|&x| x % 2 == 0).sum();
        let mut result: Vec<i32> = Vec::with_capacity(queries.len());

        for query in queries {
            let val = query[0];
            let index = query[1] as usize;

            let old_val = nums[index];

            if old_val % 2 == 0 {
                current_even_sum -= old_val;
            }

            nums[index] += val;
            let new_val = nums[index];

            if new_val % 2 == 0 {
                current_even_sum += new_val;
            }
            result.push(current_even_sum);
        }
        result
    }
}