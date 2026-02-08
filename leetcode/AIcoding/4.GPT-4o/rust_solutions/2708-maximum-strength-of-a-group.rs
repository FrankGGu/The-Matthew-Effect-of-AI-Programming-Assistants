impl Solution {
    pub fn max_strength(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut product = 1;
        let mut has_positive = false;
        let mut has_negative = false;
        let mut negative_count = 0;

        for &num in &nums {
            if num > 0 {
                has_positive = true;
                product *= num;
            } else if num < 0 {
                has_negative = true;
                negative_count += 1;
                product *= num;
            }
        }

        if negative_count % 2 != 0 {
            if has_negative {
                product /= nums[negative_count]; 
            }
        }

        if !has_positive && negative_count == 0 {
            return 0;
        }

        product
    }
}