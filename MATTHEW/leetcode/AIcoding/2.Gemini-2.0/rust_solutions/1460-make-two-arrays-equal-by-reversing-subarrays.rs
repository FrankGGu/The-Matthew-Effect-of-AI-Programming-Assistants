impl Solution {
    pub fn can_be_equal(target: Vec<i32>, arr: Vec<i32>) -> bool {
        let mut target_sorted = target.clone();
        target_sorted.sort();
        let mut arr_sorted = arr.clone();
        arr_sorted.sort();
        target_sorted == arr_sorted
    }
}