use std::collections::HashMap;

impl Solution {
    pub fn min_subarray(nums: Vec<i32>, p: i32) -> i32 {
        let p = p as i64;
        let total: i64 = nums.iter().map(|&x| x as i64).sum();
        let rem = total % p;
        if rem == 0 {
            return 0;
        }

        let mut map = HashMap::new();
        map.insert(0, -1);
        let mut res = nums.len() as i32;
        let mut sum = 0i64;

        for (i, &num) in nums.iter().enumerate() {
            sum = (sum + num as i64) % p;
            let target = (sum - rem + p) % p;
            if let Some(&prev) = map.get(&target) {
                res = res.min((i as i32 - prev) as i32);
            }
            map.insert(sum, i as i32);
        }

        if res == nums.len() as i32 || res == -1 {
            -1
        } else {
            res
        }
    }
}