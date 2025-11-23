impl Solution {
    pub fn can_sort_array(nums: Vec<i32>) -> bool {
        let mut sorted = nums.clone();
        sorted.sort();
        nums == sorted
    }
}