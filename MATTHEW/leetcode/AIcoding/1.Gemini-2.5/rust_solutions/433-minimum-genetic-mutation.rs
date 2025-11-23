use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn min_mutation(start_gene: String, end_gene: String, bank: Vec<String>) -> i32 {
        let mut queue: VecDeque<(String, i32)> = VecDeque::new();
        let mut visited: HashSet<String> = HashSet::new();
        let bank_set: HashSet<String> = bank.into_iter().collect();

        if !bank_set.contains(&end_gene) {
            return -1;
        }

        queue.push_back((start_gene.clone(), 0));
        visited.insert(start_gene);

        let nucleotides = ['A', 'C', 'G', 'T'];

        while let Some((current_gene, mutations)) = queue.pop_front() {
            if current_gene == end_gene {
                return mutations;
            }

            for i in 0..current_gene.len() {
                let mut chars: Vec<char> = current_gene.chars().collect();
                let original_char = chars[i];

                for &nuc in &nucleotides {
                    if nuc == original_char {
                        continue;
                    }

                    chars[i] = nuc;
                    let next_gene: String = chars.iter().collect();

                    if bank_set.contains(&next_gene) && !visited.contains(&next_gene) {
                        visited.insert(next_gene.clone());
                        queue.push_back((next_gene, mutations + 1));
                    }
                }
            }
        }

        -1
    }
}