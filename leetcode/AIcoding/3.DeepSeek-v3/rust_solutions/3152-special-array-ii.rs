impl Solution {
    pub fn is_array_special(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = nums.len();
        let mut prefix = vec![0; n];
        for i in 1..n {
            prefix[i] = prefix[i - 1] + if (nums[i] % 2) == (nums[i - 1] % 2) { 1 } else { 0 };
        }
        queries.into_iter().map(|q| {
            let (x, y) = (q[0] as usize, q[1] as usize);
            prefix[y] - prefix[x] == 0
        }).collect()
    }
}