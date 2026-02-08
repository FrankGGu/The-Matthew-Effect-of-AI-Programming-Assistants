impl Solution {
    pub fn count_quadruplets(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut count = 0;

        for i in 0..n {
            for j in i + 1..n {
                for k in j + 1..n {
                    for l in 0..i {
                        if nums[i] + nums[j] + nums[k] == nums[l] {
                            count += 1;
                        }
                    }
                }
            }
        }

        count
    }
}