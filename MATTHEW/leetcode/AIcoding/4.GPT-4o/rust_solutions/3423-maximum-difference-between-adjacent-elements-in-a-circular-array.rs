impl Solution {
    pub fn max_adjacent_diff(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut max_diff = 0;

        for i in 0..n {
            let diff = (arr[i] - arr[(i + 1) % n]).abs();
            max_diff = max_diff.max(diff);
        }

        max_diff
    }
}