struct Solution;

impl Solution {
    pub fn count_highest_score_nodes(parents: Vec<i32>) -> i32 {
        let n = parents.len();
        let mut children: Vec<Vec<usize>> = vec![vec![]; n];
        for i in 1..n {
            children[parents[i] as usize].push(i);
        }

        let mut subtree_sizes: Vec<usize> = vec![0; n];

        fn dfs_calculate_sizes(
            node: usize,
            children: &Vec<Vec<usize>>,
            subtree_sizes: &mut Vec<usize>,
        ) -> usize {
            let mut current_size = 1;
            for &child in children[node].iter() {
                current_size += dfs_calculate_sizes(child, children, subtree_sizes);
            }
            subtree_sizes[node] = current_size;
            current_size
        }

        dfs_calculate_sizes(0, &children, &mut subtree_sizes);

        let mut max_score: i64 = 0;
        let mut count: i32 = 0;

        for i in 0..n {
            let mut current_score: i64 = 1;

            for &child in children[i].iter() {
                current_score *= subtree_sizes[child] as i64;
            }

            let parent_part_size = n - subtree_sizes[i];
            if parent_part_size > 0 {
                current_score *= parent_part_size as i64;
            }

            if current_score > max_score {
                max_score = current_score;
                count = 1;
            } else if current_score == max_score {
                count += 1;
            }
        }

        count
    }
}