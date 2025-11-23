use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn sequence_reconstruction(org: Vec<i32>, seqs: Vec<Vec<i32>>) -> bool {
        let n = org.len();
        let mut graph: HashMap<i32, HashSet<i32>> = HashMap::new();
        let mut in_degree: HashMap<i32, i32> = HashMap::new();

        for num in &org {
            in_degree.insert(*num, 0);
        }

        let mut valid = false;
        for seq in seqs {
            if seq.is_empty() {
                continue;
            }
            let mut prev = seq[0];
            if !in_degree.contains_key(&prev) {
                return false;
            }
            for &curr in seq.iter().skip(1) {
                if !in_degree.contains_key(&curr) {
                    return false;
                }
                if graph.entry(prev).or_default().insert(curr) {
                    *in_degree.entry(curr).or_default() += 1;
                }
                prev = curr;
            }
            valid = true;
        }

        if !valid {
            return false;
        }

        let mut queue: VecDeque<i32> = VecDeque::new();
        for (&num, &degree) in &in_degree {
            if degree == 0 {
                queue.push_back(num);
            }
        }

        let mut res = Vec::new();
        while !queue.is_empty() {
            if queue.len() > 1 {
                return false;
            }
            let num = queue.pop_front().unwrap();
            res.push(num);
            if let Some(nexts) = graph.get(&num) {
                for &next in nexts {
                    let degree = in_degree.entry(next).or_default();
                    *degree -= 1;
                    if *degree == 0 {
                        queue.push_back(next);
                    }
                }
            }
        }

        res == org
    }
}