impl Solution {
    pub fn max_and_min_sums(nums: Vec<i32>, k: i32) -> Vec<i64> {
        let k = k as usize;
        let n = nums.len();
        let mut nums_clone = nums.clone();
        nums_clone.sort();

        let mut min_sum = 0i64;
        for i in 0..k {
            min_sum += nums_clone[i] as i64;
        }

        let mut max_sum = 0i64;
        for i in 0..k {
            max_sum += nums_clone[n - 1 - i] as i64;
        }

        vec![max_sum, min_sum]
    }
}