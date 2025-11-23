impl Solution {
    pub fn permute_query(n: i32, queries: Vec<i32>) -> Vec<i32> {
        let mut permutation = (1..=n).collect::<Vec<i32>>();
        let mut result = vec![];

        for &query in &queries {
            let idx = (query - 1) as usize;
            result.push(permutation[idx]);
            permutation.remove(idx);
            permutation.insert(0, result.last().unwrap().clone());
        }

        result
    }
}