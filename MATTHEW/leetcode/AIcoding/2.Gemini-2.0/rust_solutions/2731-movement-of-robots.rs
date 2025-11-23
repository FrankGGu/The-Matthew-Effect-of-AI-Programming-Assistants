impl Solution {
    pub fn sum_distance(nums: Vec<i32>, s: String) -> i32 {
        let n = nums.len();
        let mut moved: Vec<i64> = Vec::new();
        let s_bytes = s.as_bytes();
        for i in 0..n {
            if s_bytes[i] == b'L' {
                moved.push(nums[i] as i64 - 1);
            } else {
                moved.push(nums[i] as i64 + 1);
            }
        }
        moved.sort();
        let mut ans: i64 = 0;
        let mut prefix_sum: i64 = 0;
        let mod_val: i64 = 1_000_000_007;

        for i in 0..n {
            ans = (ans + moved[i] - prefix_sum) % mod_val;
            prefix_sum = (prefix_sum + moved[i]) % mod_val;
        }

        if ans < 0 {
            ans += mod_val;
        }
        ans as i32
    }
}