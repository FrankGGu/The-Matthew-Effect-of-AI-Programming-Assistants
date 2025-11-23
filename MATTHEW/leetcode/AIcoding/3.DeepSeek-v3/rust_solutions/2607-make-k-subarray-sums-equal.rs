impl Solution {
    pub fn make_sub_k_sum_equal(arr: Vec<i32>, k: i32) -> i64 {
        let n = arr.len();
        let k = k as usize;
        let mut visited = vec![false; n];
        let mut total_operations = 0i64;

        for i in 0..n {
            if !visited[i] {
                let mut group = Vec::new();
                let mut current = i;
                while !visited[current] {
                    visited[current] = true;
                    group.push(arr[current]);
                    current = (current + k) % n;
                }
                group.sort();
                let median = group[group.len() / 2];
                let operations: i64 = group.iter().map(|&x| (x - median).abs() as i64).sum();
                total_operations += operations;
            }
        }

        total_operations
    }
}