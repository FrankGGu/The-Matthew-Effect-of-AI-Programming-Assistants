pub fn transformed_array(arr: Vec<i32>, k: i32) -> Vec<i32> {
    let mut result = vec![0; arr.len()];
    for i in 0..arr.len() {
        result[i] = arr[i] + k * (i as i32);
    }
    result
}