use std::collections::BinaryHeap;

impl Solution {
    pub fn max_size_slices(slices: Vec<i32>) -> i32 {
        let n = slices.len() / 3;
        Self::calculate_max(&slices, n)
    }

    fn calculate_max(slices: &[i32], n: usize) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut next = vec![0; slices.len()];
        let mut prev = vec![0; slices.len()];
        let mut deleted = vec![false; slices.len()];

        for i in 0..slices.len() {
            next[i] = (i + 1) % slices.len();
            prev[i] = (i + slices.len() - 1) % slices.len();
            heap.push((slices[i], i));
        }

        let mut res = 0;
        let mut count = 0;

        while count < n {
            while let Some(&(val, idx)) = heap.peek() {
                if deleted[idx] {
                    heap.pop();
                } else {
                    break;
                }
            }

            if let Some((val, idx)) = heap.pop() {
                res += val;
                deleted[idx] = true;
                deleted[prev[idx]] = true;
                deleted[next[idx]] = true;

                let new_val = slices[prev[idx]] + slices[next[idx]] - val;
                slices[idx] = new_val;
                heap.push((new_val, idx));

                next[prev[prev[idx]]] = idx;
                prev[next[next[idx]]] = idx;
                prev[idx] = prev[prev[idx]];
                next[idx] = next[next[idx]];

                count += 1;
            }
        }

        res
    }
}