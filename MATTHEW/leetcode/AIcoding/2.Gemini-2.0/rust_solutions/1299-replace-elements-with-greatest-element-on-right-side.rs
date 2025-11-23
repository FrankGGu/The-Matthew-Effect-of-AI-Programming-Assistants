impl Solution {
    pub fn replace_elements(arr: Vec<i32>) -> Vec<i32> {
        let mut result = vec![0; arr.len()];
        let mut max_right = -1;
        for i in (0..arr.len()).rev() {
            result[i] = max_right;
            max_right = std::cmp::max(max_right, arr[i]);
        }
        result
    }
}