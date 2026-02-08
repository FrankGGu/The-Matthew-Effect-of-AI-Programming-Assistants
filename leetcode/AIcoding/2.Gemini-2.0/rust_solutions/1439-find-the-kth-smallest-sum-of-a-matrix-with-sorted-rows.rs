use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn kth_smallest(mat: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut pq = BinaryHeap::new();
        pq.push(Reverse(0));

        let mut visited = std::collections::HashSet::new();
        visited.insert(vec![0; m]);

        for _ in 0..k {
            let Reverse(curr_sum) = pq.pop().unwrap();

            let mut curr_indices = vec![0; m];
            let mut found = false;
            for indices in &visited {
                let sum = indices.iter().zip(mat.iter()).map(|(&i, row)| row[i as usize]).sum::<i32>();
                if sum == curr_sum {
                    curr_indices = indices.clone();
                    found = true;
                    break;
                }
            }

            if !found {
                for indices in &visited {
                    let sum = indices.iter().zip(mat.iter()).map(|(&i, row)| row[i as usize]).sum::<i32>();
                     if sum == curr_sum {
                        curr_indices = indices.clone();
                        break;
                    }
                }
            }

            if _ == k - 1 {
                return curr_sum;
            }

            for i in 0..m {
                if curr_indices[i] + 1 < n as i32 {
                    let mut next_indices = curr_indices.clone();
                    next_indices[i] += 1;
                    if !visited.contains(&next_indices) {
                        let next_sum = curr_sum - mat[i][curr_indices[i] as usize] + mat[i][next_indices[i] as usize];
                        pq.push(Reverse(next_sum));
                        visited.insert(next_indices);
                    }
                }
            }
        }

        0
    }
}