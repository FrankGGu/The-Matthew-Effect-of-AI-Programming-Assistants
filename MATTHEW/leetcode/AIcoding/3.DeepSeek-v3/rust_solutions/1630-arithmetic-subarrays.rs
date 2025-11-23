impl Solution {
    pub fn check_arithmetic_subarrays(nums: Vec<i32>, l: Vec<i32>, r: Vec<i32>) -> Vec<bool> {
        let mut res = Vec::new();
        for i in 0..l.len() {
            let left = l[i] as usize;
            let right = r[i] as usize;
            let mut subarray = nums[left..=right].to_vec();
            subarray.sort_unstable();
            let diff = subarray[1] - subarray[0];
            let mut is_arithmetic = true;
            for j in 2..subarray.len() {
                if subarray[j] - subarray[j - 1] != diff {
                    is_arithmetic = false;
                    break;
                }
            }
            res.push(is_arithmetic);
        }
        res
    }
}