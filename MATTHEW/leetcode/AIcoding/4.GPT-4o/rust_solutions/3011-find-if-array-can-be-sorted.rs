impl Solution {
    pub fn can_be_sorted(arr: Vec<i32>) -> bool {
        let mut sorted_arr = arr.clone();
        sorted_arr.sort();
        arr == sorted_arr
    }
}