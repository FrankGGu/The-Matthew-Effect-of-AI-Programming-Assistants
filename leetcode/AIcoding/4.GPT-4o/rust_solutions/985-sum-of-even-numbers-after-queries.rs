impl Solution {
    pub fn sum_even_after_queries(nums: Vec<i32>, queries: Vec<(i32, i32)>) -> Vec<i32> {
        let mut sum_even: i32 = nums.iter().filter(|&&x| x % 2 == 0).sum();
        let mut result = Vec::new();

        for (val, index) in queries {
            let old_value = nums[index as usize];
            let new_value = old_value + val;

            if old_value % 2 == 0 {
                sum_even -= old_value;
            }
            if new_value % 2 == 0 {
                sum_even += new_value;
            }

            result.push(sum_even);
        }

        result
    }
}