struct Solution;

impl Solution {
    pub fn check_arithmetic_subarrays(nums: Vec<i32>, l: Vec<i32>, r: Vec<i32>) -> Vec<bool> {
        let mut result = Vec::new();

        for (start, end) in l.iter().zip(r.iter()) {
            let start = *start as usize;
            let end = *end as usize;
            let mut subarray = nums[start..=end].to_vec();
            subarray.sort();
            let diff = subarray[1] - subarray[0];
            let mut is_arithmetic = true;

            for i in 1..subarray.len() - 1 {
                if subarray[i + 1] - subarray[i] != diff {
                    is_arithmetic = false;
                    break;
                }
            }
            result.push(is_arithmetic);
        }

        result
    }
}