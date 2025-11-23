impl Solution {
    pub fn rearrange_array(nums: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; nums.len()];
        let (mut pos, mut neg) = (0, 1);

        for &num in nums.iter().sorted() {
            if num % 2 == 0 {
                result[pos] = num;
                pos += 2;
            } else {
                result[neg] = num;
                neg += 2;
            }
        }

        result
    }
}