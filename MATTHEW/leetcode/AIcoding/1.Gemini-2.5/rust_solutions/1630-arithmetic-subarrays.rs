impl Solution {
    pub fn check_arithmetic_subarrays(nums: Vec<i32>, l: Vec<i32>, r: Vec<i32>) -> Vec<bool> {
        let mut results = Vec::with_capacity(l.len());

        for i in 0..l.len() {
            let start = l[i] as usize;
            let end = r[i] as usize;

            let mut subarray: Vec<i32> = nums[start..=end].to_vec();

            if subarray.len() < 2 {
                results.push(false);
                continue;
            }

            subarray.sort_unstable();

            let diff = subarray[1] - subarray[0];
            let mut is_arithmetic = true;

            for j in 2..subarray.len() {
                if subarray[j] - subarray[j - 1] != diff {
                    is_arithmetic = false;
                    break;
                }
            }
            results.push(is_arithmetic);
        }

        results
    }
}