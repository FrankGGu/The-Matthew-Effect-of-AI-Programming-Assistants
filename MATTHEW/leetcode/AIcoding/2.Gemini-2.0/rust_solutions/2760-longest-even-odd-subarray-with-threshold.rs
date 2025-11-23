impl Solution {
    pub fn longest_even_odd_subarray(nums: Vec<i32>, threshold: i32) -> i32 {
        let mut max_len = 0;
        let mut curr_len = 0;
        for &num in &nums {
            if num <= threshold && (curr_len == 0 || (num % 2 != nums[(nums.len() as i32 - curr_len as i32 - 1) as usize] % 2)) {
                if curr_len == 0 && num % 2 != 0 {
                    curr_len = 0;
                }
                else if curr_len == 0 && num % 2 == 0 {
                    curr_len = 1;
                }
                else {
                    curr_len += 1;
                }

                max_len = max_len.max(curr_len);
            } else {
                if num <= threshold && curr_len == 0 && num % 2 == 0 {
                    curr_len = 1;
                    max_len = max_len.max(curr_len);
                }
                else {
                    curr_len = 0;
                }

                if num <= threshold && curr_len == 0 && num % 2 == 0 {
                    curr_len = 1;
                }
            }
        }

        curr_len = 0;
        for &num in &nums {
            if num <= threshold && (curr_len == 0 || (num % 2 != nums[(nums.len() as i32 - curr_len as i32 - 1) as usize] % 2)) {
                if curr_len == 0 && num % 2 != 0 {
                    curr_len = 0;
                }
                else if curr_len == 0 && num % 2 == 0 {
                    curr_len = 1;
                }
                else {
                    curr_len += 1;
                }
            } else {
                curr_len = 0;
            }
        }

        max_len
    }
}