struct Solution;

impl Solution {
    pub fn sum_even_after_queries(mut nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        let mut even_sum = nums.iter().filter(|&&x| x % 2 == 0).sum::<i32>();

        for query in queries {
            let index = query[0] as usize;
            let value = query[1];

            if nums[index] % 2 == 0 {
                even_sum -= nums[index];
            }

            nums[index] += value;

            if nums[index] % 2 == 0 {
                even_sum += nums[index];
            }

            result.push(even_sum);
        }

        result
    }
}