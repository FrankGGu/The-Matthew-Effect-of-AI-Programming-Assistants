struct Solution;

impl Solution {
    pub fn kth_largest_number(mut nums: Vec<String>, k: i32) -> String {
        nums.sort_by(|a, b| {
            let len_a = a.len();
            let len_b = b.len();
            if len_a != len_b {
                return len_a.cmp(&len_b);
            }
            a.cmp(b)
        });
        nums[nums.len() - k as usize].clone()
    }
}