impl Solution {
    pub fn sum_even_after_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut nums = nums;
        let mut sum_even: i32 = nums.iter().filter(|&x| x % 2 == 0).sum();
        let mut result: Vec<i32> = Vec::new();

        for query in queries {
            let val = query[0];
            let index = query[1] as usize;

            if nums[index] % 2 == 0 {
                sum_even -= nums[index];
            }

            nums[index] += val;

            if nums[index] % 2 == 0 {
                sum_even += nums[index];
            }

            result.push(sum_even);
        }

        result
    }
}