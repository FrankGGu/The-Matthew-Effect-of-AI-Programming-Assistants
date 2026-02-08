impl Solution {
    pub fn count_quadruplets(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut count = 0;
        let mut less = vec![0; n];

        for j in 0..n {
            let mut cnt = 0;
            for i in 0..j {
                if nums[i] < nums[j] {
                    cnt += 1;
                }
            }
            less[j] = cnt;
        }

        for k in 1..n {
            let mut cnt = 0;
            for l in k + 1..n {
                if nums[k] < nums[l] {
                    count += less[k] as i64;
                }
            }
        }

        count
    }
}