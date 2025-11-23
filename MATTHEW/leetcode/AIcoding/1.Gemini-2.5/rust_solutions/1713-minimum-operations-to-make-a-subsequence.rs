use std::collections::HashMap;

impl Solution {
    pub fn min_operations(target: Vec<i32>, arr: Vec<i32>) -> i32 {
        let n = target.len();

        let mut target_indices: HashMap<i32, usize> = HashMap::new();
        for (i, &val) in target.iter().enumerate() {
            target_indices.insert(val, i);
        }

        let mut subsequence_indices: Vec<usize> = Vec::new();
        for &val in arr.iter() {
            if let Some(&idx) = target_indices.get(&val) {
                subsequence_indices.push(idx);
            }
        }

        let mut tails: Vec<usize> = Vec::new();
        for &num in subsequence_indices.iter() {
            let low = tails.partition_point(|&x| x < num);

            if low == tails.len() {
                tails.push(num);
            } else {
                tails[low] = num;
            }
        }

        (n - tails.len()) as i32
    }
}