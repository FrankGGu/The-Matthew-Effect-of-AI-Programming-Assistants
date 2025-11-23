impl Solution {
    pub fn count_elements(nums: Vec<i32>) -> i32 {
        if nums.len() < 3 {
            return 0;
        }

        let min_val = *nums.iter().min().unwrap();
        let max_val = *nums.iter().max().unwrap();

        if min_val == max_val {
            return 0;
        }

        let mut count = 0;
        for &num in nums.iter() {
            if num > min_val && num < max_val {
                count += 1;
            }
        }
        count
    }
}