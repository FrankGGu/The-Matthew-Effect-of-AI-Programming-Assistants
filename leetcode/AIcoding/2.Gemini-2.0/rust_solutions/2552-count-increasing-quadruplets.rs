impl Solution {
    pub fn count_quadruplets(nums: Vec<i32>) -> i64 {
        let n = nums.len();
        let mut count = 0;

        for j in 1..n - 2 {
            for i in 0..j {
                for k in j + 1..n - 1 {
                    for l in k + 1..n {
                        if nums[i] < nums[k] && nums[k] < nums[j] && nums[j] > nums[l] {
                            count += 1;
                        }
                    }
                }
            }
        }

        count as i64
    }
}