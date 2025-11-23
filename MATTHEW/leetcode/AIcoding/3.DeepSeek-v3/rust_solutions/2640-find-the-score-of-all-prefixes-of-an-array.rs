impl Solution {
    pub fn find_prefix_score(nums: Vec<i32>) -> Vec<i64> {
        let mut max_so_far = 0;
        let mut sum = 0;
        let mut res = Vec::with_capacity(nums.len());

        for &num in nums.iter() {
            max_so_far = max_so_far.max(num);
            sum += num as i64 + max_so_far as i64;
            res.push(sum);
        }

        res
    }
}