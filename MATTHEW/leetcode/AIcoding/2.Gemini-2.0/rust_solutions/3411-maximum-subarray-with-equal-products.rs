use std::collections::HashMap;

impl Solution {
    pub fn max_subarray_with_equal_products(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut ans = 0;
        let mut prefix_product = vec![1.0; n + 1];
        for i in 0..n {
            prefix_product[i + 1] = prefix_product[i] * nums[i] as f64;
        }

        for i in 0..n {
            for j in i..n {
                let product1 = prefix_product[j + 1] / prefix_product[i];
                for k in j + 1..n {
                    for l in k..n {
                        let product2 = prefix_product[l + 1] / prefix_product[k];
                        if product1 == product2 {
                            ans = ans.max((j - i + 1) as i32);
                        }
                    }
                }
            }
        }

        ans
    }
}

struct Solution;