impl Solution {
    pub fn find_stable_mountains(arr: Vec<i32>) -> Vec<i32> {
        let n = arr.len();
        let mut result = Vec::new();

        for i in 1..(n - 1) {
            if arr[i] > arr[i - 1] && arr[i] > arr[i + 1] {
                result.push(i as i32);
            }
        }

        result
    }
}