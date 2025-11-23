impl Solution {
    pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut res = n + 1;
        for i in 0..n {
            let mut or = 0;
            for j in i..n {
                or |= nums[j];
                if or >= k {
                    res = res.min(j - i + 1);
                    break;
                }
            }
        }
        if res <= n {
            res as i32
        } else {
            -1
        }
    }
}