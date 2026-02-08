impl Solution {
    pub fn closest_meeting_node(n: i32, edges: Vec<i32>, node1: i32, node2: i32) -> i32 {
        let n_usize = n as usize;

        fn get_distances(n: usize, edges: &[i32], start_node: i32) -> Vec<i32> {
            let mut distances = vec![-1; n];
            let mut current_node = start_node;
            let mut dist = 0;

            while current_node != -1 && distances[current_node as usize] == -1 {
                distances[current_node as usize] = dist;
                current_node = edges[current_node as usize];
                dist += 1;
            }
            distances
        }

        let dists1 = get_distances(n_usize, &edges, node1);
        let dists2 = get_distances(n_usize, &edges, node2);

        let mut min_max_dist = i32::MAX;
        let mut result_node = -1;

        for i in 0..n_usize {
            if dists1[i] != -1 && dists2[i] != -1 {
                let current_max_dist = dists1[i].max(dists2[i]);

                if current_max_dist < min_max_dist {
                    min_max_dist = current_max_dist;
                    result_node = i as i32;
                }
            }
        }

        result_node
    }
}