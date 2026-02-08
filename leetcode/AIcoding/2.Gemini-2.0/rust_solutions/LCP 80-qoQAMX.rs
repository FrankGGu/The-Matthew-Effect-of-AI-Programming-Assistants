impl Solution {
    pub fn min_mutation(start: String, end: String, bank: Vec<String>) -> i32 {
        use std::collections::VecDeque;
        use std::collections::HashSet;

        let mut queue = VecDeque::new();
        queue.push_back((start.clone(), 0));

        let mut visited = HashSet::new();
        visited.insert(start.clone());

        while let Some((current, steps)) = queue.pop_front() {
            if current == end {
                return steps;
            }

            for gene in &bank {
                if !visited.contains(gene) && Solution::is_one_mutation(&current, gene) {
                    queue.push_back((gene.clone(), steps + 1));
                    visited.insert(gene.clone());
                }
            }
        }

        -1
    }

    fn is_one_mutation(gene1: &String, gene2: &String) -> bool {
        let mut diff_count = 0;
        for (c1, c2) in gene1.chars().zip(gene2.chars()) {
            if c1 != c2 {
                diff_count += 1;
            }
        }
        diff_count == 1
    }
}