impl Solution {
    pub fn find_the_array_concVal(nums: Vec<i32>) -> i64 {
        let mut left = 0;
        let mut right = nums.len() - 1;
        let mut sum: i64 = 0;

        while left < right {
            let num1 = nums[left].to_string();
            let num2 = nums[right].to_string();
            let concatenated = num1 + &num2;
            sum += concatenated.parse::<i64>().unwrap();
            left += 1;
            right -= 1;
        }

        if left == right {
            sum += nums[left] as i64;
        }

        sum
    }
}