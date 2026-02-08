impl Solution {
    pub fn semi_ordered_permutation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut idx1 = 0;
        let mut idxn = 0;

        for i in 0..n {
            if nums[i] == 1 {
                idx1 = i;
            }
            if nums[i] == n as i32 {
                idxn = i;
            }
        }

        if idx1 < idxn {
            (idx1 + (n - 1) - idxn) as i32
        } else {
            (idx1 + (n - 1) - (idxn + 1)) as i32
        }
    }
}