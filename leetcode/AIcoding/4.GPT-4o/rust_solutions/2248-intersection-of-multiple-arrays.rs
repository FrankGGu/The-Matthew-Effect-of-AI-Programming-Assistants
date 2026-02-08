impl Solution {
    pub fn intersection(arrays: Vec<Vec<i32>>) -> Vec<i32> {
        use std::collections::HashSet;
        let mut counts = vec![0; 1001];
        let n = arrays.len();
        let mut result = HashSet::new();

        for array in arrays {
            let mut seen = HashSet::new();
            for &num in &array {
                if !seen.contains(&num) {
                    counts[num as usize] += 1;
                    seen.insert(num);
                }
            }
        }

        for i in 0..1001 {
            if counts[i] == n {
                result.insert(i);
            }
        }

        let mut result_vec: Vec<i32> = result.into_iter().collect();
        result_vec.sort();
        result_vec
    }
}