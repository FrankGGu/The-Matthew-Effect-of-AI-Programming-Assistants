impl Solution {
    pub fn check_array(nums: Vec<i32>, k: i32) -> bool {
        let n = nums.len();
        let k = k as usize;
        let mut diff = vec![0; n + 1];
        let mut current = 0;

        for i in 0..n {
            current += diff[i];
            let adjusted = nums[i] + current;
            if adjusted == 0 {
                continue;
            } else if adjusted < 0 || i + k > n {
                return false;
            } else {
                current -= adjusted;
                if i + k < n {
                    diff[i + k] += adjusted;
                }
            }
        }
        true
    }
}