use std::collections::BinaryHeap;

impl Solution {
    pub fn k_weakest_rows(mat: Vec<Vec<i32>>, k: i32) -> Vec<i32> {
        let mut heap = BinaryHeap::new();
        for (i, row) in mat.iter().enumerate() {
            let count = row.iter().take_while(|&&x| x == 1).count();
            heap.push((count, -i));
            if heap.len() > k as usize {
                heap.pop();
            }
        }
        let mut result = vec![];
        while let Some((_, neg_index)) = heap.pop() {
            result.push(-neg_index);
        }
        result.reverse();
        result
    }
}