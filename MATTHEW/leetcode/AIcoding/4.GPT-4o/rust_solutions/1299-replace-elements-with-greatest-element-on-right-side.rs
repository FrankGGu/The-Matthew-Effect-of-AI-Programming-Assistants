impl Solution {
    pub fn replace_elements(arr: Vec<i32>) -> Vec<i32> {
        let mut result = arr.clone();
        let mut max_from_right = -1;

        for i in (0..arr.len()).rev() {
            result[i] = max_from_right;
            max_from_right = max_from_right.max(arr[i]);
        }

        result
    }
}