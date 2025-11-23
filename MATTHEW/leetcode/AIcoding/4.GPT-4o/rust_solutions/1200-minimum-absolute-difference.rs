impl Solution {
    pub fn minimum_abs_difference(arr: Vec<i32>) -> Vec<Vec<i32>> {
        let mut arr = arr;
        arr.sort();
        let mut result = Vec::new();
        let mut min_diff = i32::MAX;

        for i in 1..arr.len() {
            let diff = arr[i] - arr[i - 1];
            if diff < min_diff {
                min_diff = diff;
                result.clear();
                result.push(vec![arr[i - 1], arr[i]]);
            } else if diff == min_diff {
                result.push(vec![arr[i - 1], arr[i]]);
            }
        }

        result
    }
}