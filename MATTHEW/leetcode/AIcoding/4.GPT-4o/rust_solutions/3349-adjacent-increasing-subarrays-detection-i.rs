pub fn has_adjacent_increasing(arr: Vec<i32>) -> bool {
    for i in 1..arr.len() {
        if arr[i] > arr[i - 1] {
            return true;
        }
    }
    false
}