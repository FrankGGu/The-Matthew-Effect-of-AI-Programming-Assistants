impl Solution {
    pub fn range_sum(nums: Vec<i32>, n: i32, left: i32, right: i32) -> i32 {
        let n = n as usize;
        let mut subarray_sums = Vec::new();

        for i in 0..n {
            let mut sum = 0;
            for j in i..n {
                sum += nums[j];
                subarray_sums.push(sum);
            }
        }

        subarray_sums.sort();

        let left = left as usize;
        let right = right as usize;
        let mut result = 0;
        for i in (left - 1)..right {
            result = (result + subarray_sums[i]) % 1_000_000_007;
        }

        result
    }
}