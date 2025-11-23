use std::collections::BinaryHeap;

pub fn kth_smallest(mat: Vec<Vec<i32>>, k: i32) -> i32 {
    let m = mat.len();
    let n = mat[0].len();
    let mut min_heap = BinaryHeap::new();
    let mut initial_sum = 0;

    for i in 0..m {
        initial_sum += mat[i][0];
    }

    min_heap.push((initial_sum, vec![0; m]));

    for _ in 0..k - 1 {
        let (current_sum, indices) = min_heap.pop().unwrap();

        for i in 0..m {
            if indices[i] + 1 < n {
                let mut new_indices = indices.clone();
                new_indices[i] += 1;
                let new_sum = current_sum - mat[i][indices[i]] + mat[i][new_indices[i]];
                min_heap.push((new_sum, new_indices));
            }
        }
    }

    min_heap.pop().unwrap().0
}