use std::collections::HashMap;

impl Solution {
    pub fn find_the_number_of_copy_arrays(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            for len in 1..=(n - i) {
                let sub_array1 = &nums[i..i + len];

                for j in i + len..=n - len {
                    let sub_array2 = &nums[j..j + len];

                    if sub_array1 == sub_array2 {
                        count += 1;
                    }
                }
            }
        }

        count
    }
}