impl Solution {
    pub fn get_intervals(arr: Vec<i32>) -> Vec<i64> {
        use std::collections::HashMap;

        let mut positions: HashMap<i32, Vec<i64>> = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            positions.entry(num).or_insert_with(Vec::new).push(i as i64);
        }

        let mut result = vec![0; arr.len()];
        for indices in positions.values() {
            let n = indices.len();
            for j in 0..n {
                let left = if j == 0 { -1 } else { indices[j - 1] };
                let right = if j == n - 1 { arr.len() as i64 } else { indices[j + 1] };
                result[indices[j] as usize] = (indices[j] - left) * (right - indices[j]);
            }
        }
        result
    }
}