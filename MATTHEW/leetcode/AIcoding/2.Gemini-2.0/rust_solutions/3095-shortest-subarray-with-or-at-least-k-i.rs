impl Solution {
    pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut ans = n as i32 + 1;
        for i in 0..n {
            let mut or_val = 0;
            for j in i..n {
                or_val |= nums[j];
                if or_val >= k {
                    ans = ans.min((j - i + 1) as i32);
                    break;
                }
            }
        }
        if ans > n as i32 {
            -1
        } else {
            ans
        }
    }
}