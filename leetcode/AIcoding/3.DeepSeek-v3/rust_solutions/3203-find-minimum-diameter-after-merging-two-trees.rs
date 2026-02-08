use std::collections::VecDeque;
use std::usize;

impl Solution {
    pub fn find_minimum_diameter(a: Vec<Vec<i32>>, b: Vec<Vec<i32>>) -> i32 {
        let tree1 = Self::build_tree(&a);
        let tree2 = Self::build_tree(&b);

        let (d1, centers1) = Self::find_tree_centers(&tree1);
        let (d2, centers2) = Self::find_tree_centers(&tree2);

        let mut min_diameter = usize::MAX;

        for &c1 in &centers1 {
            for &c2 in &centers2 {
                let merged_diameter = Self::calculate_merged_diameter(&tree1, &tree2, c1, c2, d1, d2);
                if merged_diameter < min_diameter {
                    min_diameter = merged_diameter;
                }
            }
        }

        min_diameter as i32
    }

    fn build_tree(edges: &Vec<Vec<i32>>) -> Vec<Vec<usize>> {
        let n = edges.len() + 1;
        let mut tree = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            tree[u].push(v);
            tree[v].push(u);
        }
        tree
    }

    fn find_tree_centers(tree: &Vec<Vec<usize>>) -> (usize, Vec<usize>) {
        let n = tree.len();
        let mut degree = vec![0; n];
        let mut leaves = VecDeque::new();

        for i in 0..n {
            degree[i] = tree[i].len();
            if degree[i] <= 1 {
                leaves.push_back(i);
                degree[i] = 0;
            }
        }

        let mut count = leaves.len();
        while count < n {
            let len = leaves.len();
            for _ in 0..len {
                let u = leaves.pop_front().unwrap();
                for &v in &tree[u] {
                    if degree[v] > 0 {
                        degree[v] -= 1;
                        if degree[v] == 1 {
                            leaves.push_back(v);
                            degree[v] = 0;
                        }
                    }
                }
            }
            count += leaves.len();
        }

        let centers: Vec<usize> = leaves.into_iter().collect();
        let diameter = if centers.len() == 2 { 2 * centers.len() - 1 } else { 2 * centers.len() };
        (diameter, centers)
    }

    fn calculate_merged_diameter(
        tree1: &Vec<Vec<usize>>,
        tree2: &Vec<Vec<usize>>,
        c1: usize,
        c2: usize,
        d1: usize,
        d2: usize,
    ) -> usize {
        let radius1 = (d1 + 1) / 2;
        let radius2 = (d2 + 1) / 2;
        let merged_radius = radius1.max(radius2).max((radius1 + radius2 + 1) / 2);
        2 * merged_radius
    }
}