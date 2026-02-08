impl Solution {
    pub fn encrypt(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n == 0 {
            return vec![];
        }
        let mut res = vec![0; n];
        for i in 0..n {
            let prev = if i == 0 { nums[n - 1] } else { nums[i - 1] };
            let next = if i == n - 1 { nums[0] } else { nums[i + 1] };
            res[i] = prev + next;
        }
        res
    }
}