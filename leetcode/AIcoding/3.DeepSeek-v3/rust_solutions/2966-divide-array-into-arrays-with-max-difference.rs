impl Solution {
    pub fn divide_array(mut nums: Vec<i32>, k: i32) -> Vec<Vec<i32>> {
        nums.sort_unstable();
        let mut result = Vec::new();
        for chunk in nums.chunks(3) {
            if chunk[2] - chunk[0] > k {
                return Vec::new();
            }
            result.push(chunk.to_vec());
        }
        result
    }
}