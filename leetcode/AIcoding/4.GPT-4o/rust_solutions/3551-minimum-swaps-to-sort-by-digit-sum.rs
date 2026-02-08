use std::collections::HashMap;

impl Solution {
    pub fn minimum_swaps(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut indexed_arr: Vec<(i32, usize)> = arr.iter().enumerate().map(|(i, &val)| (val, i)).collect();
        indexed_arr.sort();

        let mut visited = vec![false; n];
        let mut swaps = 0;

        for i in 0..n {
            if visited[i] || indexed_arr[i].1 == i {
                continue;
            }

            let mut cycle_size = 0;
            let mut j = i;

            while !visited[j] {
                visited[j] = true;
                j = indexed_arr[j].1;
                cycle_size += 1;
            }

            if cycle_size > 0 {
                swaps += cycle_size - 1;
            }
        }

        swaps
    }
}