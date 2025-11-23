impl Solution {
    pub fn find_valid_split(nums: Vec<i32>) -> bool {
        use std::collections::HashSet;

        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 { a } else { gcd(b, a % b) }
        }

        let n = nums.len();
        let mut can_split = vec![false; n + 1];
        can_split[0] = true;

        for i in 0..n {
            if can_split[i] {
                let mut g = nums[i];
                for j in i + 1..n {
                    g = gcd(g, nums[j]);
                    if g == 1 {
                        can_split[j + 1] = true;
                    }
                }
            }
        }

        can_split[n]
    }
}