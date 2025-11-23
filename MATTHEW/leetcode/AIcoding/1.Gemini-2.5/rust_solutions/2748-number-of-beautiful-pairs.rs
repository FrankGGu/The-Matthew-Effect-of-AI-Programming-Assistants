impl Solution {
    pub fn beautiful_pairs(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            let mut first_digit_i = nums[i];
            while first_digit_i >= 10 {
                first_digit_i /= 10;
            }

            for j in (i + 1)..n {
                let last_digit_j = nums[j] % 10;

                if first_digit_i == last_digit_j {
                    count += 1;
                }
            }
        }
        count
    }
}