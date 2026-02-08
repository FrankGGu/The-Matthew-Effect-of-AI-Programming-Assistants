impl Solution {
    pub fn semi_ordered_permutation(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let pos1 = nums.iter().position(|&x| x == 1).unwrap();
        let posn = nums.iter().position(|&x| x == n as i32).unwrap();
        if pos1 < posn {
            (pos1 + (n - 1 - posn)) as i32
        } else {
            (pos1 + (n - 1 - posn) - 1) as i32
        }
    }
}