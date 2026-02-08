impl Solution {
    pub fn sum_even_after_queries(mut nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut sum_even: i32 = nums.iter().filter(|&x| x % 2 == 0).sum();
        let mut res = Vec::with_capacity(queries.len());

        for query in queries {
            let val = query[0];
            let index = query[1] as usize;
            let old_val = nums[index];

            if old_val % 2 == 0 {
                sum_even -= old_val;
            }

            nums[index] += val;

            if nums[index] % 2 == 0 {
                sum_even += nums[index];
            }

            res.push(sum_even);
        }

        res
    }
}