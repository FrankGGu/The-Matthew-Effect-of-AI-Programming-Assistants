impl Solution {
    pub fn can_be_equal(target: Vec<i32>, arr: Vec<i32>) -> bool {
        let mut target_sorted = target.clone();
        let mut arr_sorted = arr.clone();
        target_sorted.sort_unstable();
        arr_sorted.sort_unstable();
        target_sorted == arr_sorted
    }
}