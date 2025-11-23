impl Solution {
    pub fn max_xor_subarray_queries(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut sorted_nums = nums.clone();
        sorted_nums.sort();

        let mut result = Vec::new();
        for query in queries {
            let xor = query[0];
            let m = query[1];

            let mut max_xor = -1;
            for &num in sorted_nums.iter().filter(|&&num| num <= m) {
                max_xor = max_xor.max(xor ^ num);
            }
            result.push(max_xor);
        }

        result
    }
}