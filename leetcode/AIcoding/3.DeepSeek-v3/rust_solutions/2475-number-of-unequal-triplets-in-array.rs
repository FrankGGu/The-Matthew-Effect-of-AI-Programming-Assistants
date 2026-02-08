impl Solution {
    pub fn unequal_triplets(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = nums.len();
        for i in 0..n {
            for j in i+1..n {
                if nums[i] == nums[j] {
                    continue;
                }
                for k in j+1..n {
                    if nums[i] != nums[k] && nums[j] != nums[k] {
                        count += 1;
                    }
                }
            }
        }
        count
    }
}