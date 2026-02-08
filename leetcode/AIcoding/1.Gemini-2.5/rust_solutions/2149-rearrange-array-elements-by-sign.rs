impl Solution {
    pub fn rearrange_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut pos_idx = 0;
        let mut neg_idx = 1;

        for &num in nums.iter() {
            if num > 0 {
                result[pos_idx] = num;
                pos_idx += 2;
            } else {
                result[neg_idx] = num;
                neg_idx += 2;
            }
        }

        result
    }
}