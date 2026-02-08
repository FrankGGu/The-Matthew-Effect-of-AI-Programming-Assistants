impl Solution {
    pub fn apply_operations(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        let k = k as usize;
        let mut diff = vec![0; n + 1];
        for i in 0..n {
            diff[i] += nums[i];
            if diff[i] != 0 {
                if i + k > n {
                    return false;
                }
                let d = diff[i];
                for j in i..i + k {
                    diff[j] -= d;
                }
            }
        }
        true
    }
}