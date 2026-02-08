impl Solution {
    pub fn rearrange_array(nums: Vec<i32>) -> Vec<i32> {
        let mut res = vec![0; nums.len()];
        let (mut pos, mut neg) = (0, 1);

        for &num in &nums {
            if num > 0 {
                res[pos] = num;
                pos += 2;
            } else {
                res[neg] = num;
                neg += 2;
            }
        }

        res
    }
}