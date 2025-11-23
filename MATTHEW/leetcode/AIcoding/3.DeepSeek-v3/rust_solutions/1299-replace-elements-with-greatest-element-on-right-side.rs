impl Solution {
    pub fn replace_elements(arr: Vec<i32>) -> Vec<i32> {
        let mut max = -1;
        let mut res = vec![0; arr.len()];
        for i in (0..arr.len()).rev() {
            res[i] = max;
            if arr[i] > max {
                max = arr[i];
            }
        }
        res
    }
}