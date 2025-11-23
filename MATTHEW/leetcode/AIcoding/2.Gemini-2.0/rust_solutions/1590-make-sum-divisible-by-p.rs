impl Solution {
    pub fn min_sub_array_len(nums: Vec<i32>, p: i32) -> i32 {
        let n = nums.len();
        let mut rem = 0;
        for &num in &nums {
            rem = (rem + num as i64) % (p as i64);
        }
        if rem == 0 {
            return 0;
        }
        let mut ans = n as i32;
        let mut map = std::collections::HashMap::new();
        map.insert(0, -1);
        let mut curr = 0;
        for i in 0..n {
            curr = (curr + nums[i] as i64) % (p as i64);
            let target = (curr - rem + p as i64) % (p as i64);
            if let Some(&idx) = map.get(&(target as i32)) {
                ans = ans.min((i as i32) - idx);
            }
            map.insert(curr as i32, i as i32);
        }
        if ans == n as i32 {
            return -1;
        }
        ans
    }
}