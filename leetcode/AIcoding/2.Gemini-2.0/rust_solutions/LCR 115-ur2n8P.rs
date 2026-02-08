use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn sequence_reconstruction(sequences: Vec<Vec<i32>>, n: i32) -> bool {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut indegree: HashMap<i32, i32> = HashMap::new();

        for i in 1..=n {
            indegree.insert(i, 0);
        }

        for seq in &sequences {
            for i in 0..seq.len() {
                if !adj.contains_key(&seq[i]) {
                    adj.insert(seq[i], Vec::new());
                }
                if !indegree.contains_key(&seq[i]) {
                    indegree.insert(seq[i], 0);
                }
                if i < seq.len() - 1 {
                    if !adj.contains_key(&seq[i]) {
                        adj.insert(seq[i], Vec::new());
                    }
                    if !indegree.contains_key(&seq[i + 1]) {
                        indegree.insert(seq[i + 1], 0);
                    }

                    let neighbors = adj.get_mut(&seq[i]).unwrap();
                    if !neighbors.contains(&seq[i + 1]) {
                        neighbors.push(seq[i + 1]);
                        *indegree.entry(seq[i + 1]).or_insert(0) += 1;
                    }
                }
            }
        }

        let mut queue: VecDeque<i32> = VecDeque::new();
        for i in 1..=n {
            if *indegree.get(&i).unwrap() == 0 {
                queue.push_back(i);
            }
        }

        let mut count = 0;
        let mut result = Vec::new();
        while !queue.is_empty() {
            if queue.len() > 1 {
                return false;
            }

            let u = queue.pop_front().unwrap();
            result.push(u);
            count += 1;

            if let Some(neighbors) = adj.get(&u) {
                for &v in neighbors {
                    *indegree.entry(v).or_insert(0) -= 1;
                    if *indegree.get(&v).unwrap() == 0 {
                        queue.push_back(v);
                    }
                }
            }
        }

        count == n
    }
}