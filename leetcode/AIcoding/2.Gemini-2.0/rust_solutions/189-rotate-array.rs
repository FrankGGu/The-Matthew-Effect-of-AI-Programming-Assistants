impl Solution {
    pub fn rotate(nums: &mut Vec<i32>, k: i32) {
        let n = nums.len();
        let k = (k % n as i32) as usize;
        nums.rotate_right(k);
    }
}