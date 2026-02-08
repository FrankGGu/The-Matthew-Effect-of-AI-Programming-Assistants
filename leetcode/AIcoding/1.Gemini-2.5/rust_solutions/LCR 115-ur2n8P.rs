use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn sequence_reconstruction(org: Vec<i32>, seqs: Vec<Vec<i32>>) -> bool {
        let n = org.len();

        if n == 0 {
            return true;
        }

        let mut adj: Vec<Vec<i32>> = vec![vec![]; n + 1];
        let mut in_degree: Vec<i32> = vec![0; n + 1];
        let mut seen_elements_in_seqs: Vec<bool> = vec![false; n + 1];
        let mut edges: HashSet<(i32, i32)> = HashSet::new();
        let mut has_any_sequence = false;

        for seq in seqs.iter() {
            if seq.is_empty() {
                continue;
            }
            has_any_sequence = true;

            let first_val = seq[0];
            if first_val < 1 || first_val > n as i32 {
                return false;
            }
            seen_elements_in_seqs[first_val as usize] = true;

            for i in 0..seq.len() - 1 {
                let u = seq[i];
                let v = seq[i+1];

                if u < 1 || u > n as i32 || v < 1 || v > n as i32 {
                    return false;
                }

                seen_elements_in_seqs[u as usize] = true;
                seen_elements_in_seqs[v as usize] = true;

                if edges.insert((u, v)) {
                    // Edge is new, add to graph structures
                    adj[u as usize].push(v);
                    in_degree[v as usize] += 1;
                }
            }
        }

        if n > 0 && !has_any_sequence {
            return false;
        }

        for i in 1..=n {
            if !seen_elements_in_seqs[i] {
                return false;
            }
        }

        let mut q: VecDeque<i32> = VecDeque::new();
        for i in 1..=n {
            if in_degree[i] == 0 {
                q.push_back(i as i32);
            }
        }

        let mut reconstructed_sequence: Vec<i32> = Vec::new();

        while let Some(u) = q.pop_front() {
            if q.len() > 0 {
                return false; // Not unique
            }

            reconstructed_sequence.push(u);

            for &v in adj[u as usize].iter() {
                in_degree[v as usize] -= 1;
                if in_degree[v as usize] == 0 {
                    q.push_back(v);
                }
            }
        }

        reconstructed_sequence.len() == n && reconstructed_sequence == org
    }
}