use std::collections::VecDeque;

impl Solution {
    pub fn num_of_ways(n: i32, relations: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = n as usize;
        let k = k as usize;
        let mut graph = vec![vec![]; n];
        for relation in &relations {
            graph[relation[0] as usize].push(relation[1] as usize);
        }

        let mut queue = VecDeque::new();
        queue.push_back((0, 0));
        let mut count = 0;

        while let Some((node, steps)) = queue.pop_front() {
            if steps == k {
                if node == n - 1 {
                    count += 1;
                }
                continue;
            }

            if steps > k {
                continue;
            }

            for &neighbor in &graph[node] {
                queue.push_back((neighbor, steps + 1));
            }
        }

        count
    }
}