struct TreeInfo {
    diameter: i32,
    min_eccentricity: i32, // This is the minimum radius
}

impl Solution {
    pub fn get_tree_info(n: i32, edges: &Vec<Vec<i32>>) -> TreeInfo {
        if n == 0 {
            return TreeInfo { diameter: 0, min_eccentricity: 0 };
        }
        if n == 1 {
            return TreeInfo { diameter: 0, min_eccentricity: 0 };
        }

        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut down_max_depth = vec![0; n_usize];
        let mut tree_diameter = 0;

        // DFS1: Calculate down_max_depth for all nodes and overall diameter
        // down_max_depth[u] = max distance from u to any node in its subtree (when rooted at 0)
        fn dfs1(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            down_max_depth: &mut Vec<i32>,
            tree_diameter: &mut i32,
        ) -> i32 {
            let mut max1 = 0; // longest path down from u
            let mut max2 = 0; // second longest path down from u

            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                let child_depth = dfs1(v, u, adj, down_max_depth, tree_diameter);
                if child_depth + 1 > max1 {
                    max2 = max1;
                    max1 = child_depth + 1;
                } else if child_depth + 1 > max2 {
                    max2 = child_depth + 1;
                }
            }

            *tree_diameter = (*tree_diameter).max(max1 + max2);
            down_max_depth[u] = max1; // Store max depth from u to any node in its (DFS) subtree
            max1 // Return max depth from u for its parent
        }

        dfs1(0, n_usize, &adj, &mut down_max_depth, &mut tree_diameter);

        // DFS2: Calculate up_max_depth for all nodes
        // up_max_depth[u] = max distance from u to any node NOT in its subtree (towards parent)
        let mut up_max_depth = vec![0; n_usize];

        fn dfs2(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            down_max_depth: &Vec<i32>,
            up_max_depth: &mut Vec<i32>,
        ) {
            let mut max1_child_path = -1; // longest path from u to a child, length (down_max_depth[v]+1)
            let mut max2_child_path = -1; // second longest path
            let mut max1_child_idx = n_usize; // index of child corresponding to max1_child_path

            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                let path_len = down_max_depth[v] + 1;
                if path_len > max1_child_path {
                    max2_child_path = max1_child_path;
                    max1_child_path = path_len;
                    max1_child_idx = v;
                } else if path_len > max2_child_path {
                    max2_child_path = path_len;
                }
            }

            for &v in &adj[u] {
                if v == p {
                    continue;
                }

                let mut current_up_path_len = up_max_depth[u] + 1; // Path going up from v to u, then up from u

                // Path going up from v to u, then down from u to another child
                // If v is on the longest path from u downwards, use the second longest path from u.
                // Otherwise, use the longest path from u.
                if v == max1_child_idx { 
                    current_up_path_len = current_up_path_len.max(max2_child_path + 1);
                } else { 
                    current_up_path_len = current_up_path_len.max(max1_child_path + 1);
                }

                up_max_depth[v] = current_up_path_len;
                dfs2(v, u, adj, down_max_depth, up_max_depth);
            }
        }

        dfs2(0, n_usize, &adj, &down_max_depth, &mut up_max_depth);

        // Step 3: Calculate eccentricity for each node and find the minimum
        let mut min_eccentricity = i32::MAX;
        for i in 0..n_usize {
            let eccentricity = down_max_depth[i].max(up_max_depth[i]);
            min_eccentricity = min_eccentricity.min(eccentricity);
        }

        TreeInfo {
            diameter: tree_diameter,
            min_eccentricity: min_eccentricity,
        }
    }

    pub fn find_minimum_diameter_after_merging_two_trees(
        n1: i32,
        edges1: Vec<Vec<i32>>,
        n2: i32,
        edges2: Vec<Vec<i32>>,
    ) -> i32 {
        let info1 = Self::get_tree_info(n1, &edges1);
        let info2 = Self::get_tree_info(n2, &edges2);

        let d1 = info1.diameter;
        let r1 = info1.min_eccentricity;
        let d2 = info2.diameter;
        let r2 = info2.min_eccentricity;

        // The diameter of the merged tree can be:
        // 1. The diameter of tree1 itself (d1).
        // 2. The diameter of tree2 itself (d2).
        // 3. A path that goes through the newly added edge.
        //    This path would be (path in tree1) -> (new edge) -> (path in tree2).
        //    To minimize this path length, we connect nodes that are "centers" of their respective trees.
        //    The length would be (min_eccentricity of tree1) + 1 (for new edge) + (min_eccentricity of tree2).
        //    This is r1 + 1 + r2.

        let merged_path_diameter = r1 + 1 + r2;

        d1.max(d2).max(merged_path_diameter)
    }
}