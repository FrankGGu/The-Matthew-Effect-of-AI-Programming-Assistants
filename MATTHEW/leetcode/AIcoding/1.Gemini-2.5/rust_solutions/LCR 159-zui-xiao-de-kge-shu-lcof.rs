impl Solution {
    pub fn find_kth_largest(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable_by(|a, b| b.cmp(a));
        nums[(k - 1) as usize]
    }
}