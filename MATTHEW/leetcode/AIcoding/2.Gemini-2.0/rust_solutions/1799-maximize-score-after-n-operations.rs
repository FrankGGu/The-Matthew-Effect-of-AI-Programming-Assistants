impl Solution {
    pub fn max_score(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut memo: Vec<i32> = vec![-1; 1 << n];

        fn gcd(a: i32, b: i32) -> i32 {
            if b == 0 {
                a
            } else {
                gcd(b, a % b)
            }
        }

        fn solve(mask: i32, nums: &Vec<i32>, memo: &mut Vec<i32>, op: i32) -> i32 {
            if mask == (1 << nums.len()) - 1 {
                return 0;
            }

            if memo[mask as usize] != -1 {
                return memo[mask as usize];
            }

            let mut ans = 0;
            for i in 0..nums.len() {
                if (mask & (1 << i)) == 0 {
                    for j in i + 1..nums.len() {
                        if (mask & (1 << j)) == 0 {
                            let new_mask = mask | (1 << i) | (1 << j);
                            ans = ans.max(op * gcd(nums[i], nums[j]) + solve(new_mask, nums, memo, op + 1));
                        }
                    }
                    break;
                }
            }

            memo[mask as usize] = ans;
            ans
        }

        solve(0, &nums, &mut memo, 1)
    }
}