impl Solution {
    pub fn find_the_array_conc_val(nums: Vec<i32>) -> i64 {
        let mut left = 0;
        let mut right = nums.len() - 1;
        let mut sum = 0i64;

        while left <= right {
            if left == right {
                sum += nums[left] as i64;
            } else {
                let concat = format!("{}{}", nums[left], nums[right]).parse::<i64>().unwrap();
                sum += concat;
            }
            left += 1;
            right -= 1;
        }

        sum
    }
}