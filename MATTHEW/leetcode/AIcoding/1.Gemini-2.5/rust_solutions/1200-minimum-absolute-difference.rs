impl Solution {
    pub fn minimum_absolute_difference(mut arr: Vec<i32>) -> Vec<Vec<i32>> {
        arr.sort_unstable();

        let mut min_diff = i32::MAX;
        for i in 0..arr.len() - 1 {
            let diff = arr[i + 1] - arr[i];
            if diff < min_diff {
                min_diff = diff;
            }
        }

        let mut result = Vec::new();
        for i in 0..arr.len() - 1 {
            if arr[i + 1] - arr[i] == min_diff {
                result.push(vec![arr[i], arr[i + 1]]);
            }
        }

        result
    }
}