impl Solution {
    pub fn check_arithmetic_subarrays(nums: Vec<i32>, l: Vec<i32>, r: Vec<i32>) -> Vec<bool> {
        let mut result = Vec::new();
        for i in 0..l.len() {
            let start = l[i] as usize;
            let end = r[i] as usize;
            let mut subarray = nums[start..=end].to_vec();
            subarray.sort();
            if subarray.len() < 2 {
                result.push(true);
                continue;
            }
            let diff = subarray[1] - subarray[0];
            let mut is_arithmetic = true;
            for j in 2..subarray.len() {
                if subarray[j] - subarray[j - 1] != diff {
                    is_arithmetic = false;
                    break;
                }
            }
            result.push(is_arithmetic);
        }
        result
    }
}