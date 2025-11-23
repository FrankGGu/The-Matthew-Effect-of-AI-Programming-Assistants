impl Solution {
    pub fn average_value(nums: Vec<i32>) -> i32 {
        let filtered: Vec<i32> = nums.into_iter().filter(|&x| x % 6 == 0).collect();
        if filtered.is_empty() {
            return 0;
        }
        let sum: i32 = filtered.iter().sum();
        sum / filtered.len() as i32
    }
}