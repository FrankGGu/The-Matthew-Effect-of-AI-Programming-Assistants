use std::collections::VecDeque;

impl Solution {
    pub fn min_mutation(start_gene: String, end_gene: String, bank: Vec<String>) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back((start_gene.clone(), 0));
        let mut visited = std::collections::HashSet::new();
        visited.insert(start_gene.clone());

        while let Some((current_gene, steps)) = queue.pop_front() {
            if current_gene == end_gene {
                return steps;
            }

            for gene in &bank {
                if !visited.contains(gene) && Solution::is_valid_mutation(&current_gene, gene) {
                    queue.push_back((gene.clone(), steps + 1));
                    visited.insert(gene.clone());
                }
            }
        }

        -1
    }

    fn is_valid_mutation(gene1: &str, gene2: &str) -> bool {
        let mut diff = 0;
        for (c1, c2) in gene1.chars().zip(gene2.chars()) {
            if c1 != c2 {
                diff += 1;
            }
        }
        diff == 1
    }
}