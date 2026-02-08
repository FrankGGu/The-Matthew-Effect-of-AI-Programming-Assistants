impl Solution {
    pub fn minimum_absolute_difference(arr: Vec<i32>) -> Vec<Vec<i32>> {
        let mut arr = arr;
        arr.sort();
        let mut min_diff = i32::MAX;
        for i in 0..arr.len() - 1 {
            let diff = (arr[i + 1] - arr[i]).abs();
            min_diff = min_diff.min(diff);
        }

        let mut result = Vec::new();
        for i in 0..arr.len() - 1 {
            let diff = (arr[i + 1] - arr[i]).abs();
            if diff == min_diff {
                result.push(vec![arr[i], arr[i + 1]]);
            }
        }

        result
    }
}