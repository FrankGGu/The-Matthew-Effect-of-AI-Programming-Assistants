impl Solution {
    pub fn kth_largest_number(nums: Vec<String>, k: i32) -> String {
        let mut nums = nums;

        nums.sort_by(|a, b| {
            if a.len() != b.len() {
                if a.len() > b.len() {
                    std::cmp::Ordering::Less
                } else {
                    std::cmp::Ordering::Greater
                }
            } else {
                b.cmp(a)
            }
        });

        nums[(k - 1) as usize].clone()
    }
}