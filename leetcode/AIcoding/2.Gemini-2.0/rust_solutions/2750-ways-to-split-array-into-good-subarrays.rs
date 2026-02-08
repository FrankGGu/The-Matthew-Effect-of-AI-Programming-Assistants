const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn number_of_ways(nums: Vec<i32>) -> i32 {
        let mut first = -1;
        let mut last = -1;
        let n = nums.len();
        for i in 0..n {
            if nums[i] == 1 {
                if first == -1 {
                    first = i as i32;
                }
                last = i as i32;
            }
        }

        if first == -1 {
            return 0;
        }

        let mut ans: i64 = 1;
        let mut prev = first;
        for i in (first + 1)..=last {
            if nums[i as usize] == 1 {
                ans = (ans * (i - prev)) % MOD;
                prev = i;
            }
        }

        ans as i32
    }
}