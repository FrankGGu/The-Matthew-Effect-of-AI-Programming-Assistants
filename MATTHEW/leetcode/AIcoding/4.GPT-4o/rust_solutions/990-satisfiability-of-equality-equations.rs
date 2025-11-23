impl Solution {
    pub fn equations_possible(equations: Vec<String>) -> bool {
        let mut parent = (0..26).collect::<Vec<_>>();

        fn find(parent: &mut Vec<usize>, x: usize) -> usize {
            if parent[x] != x {
                parent[x] = find(parent, parent[x]);
            }
            parent[x]
        }

        fn union(parent: &mut Vec<usize>, x: usize, y: usize) {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x != root_y {
                parent[root_x] = root_y;
            }
        }

        for equation in &equations {
            if equation.as_bytes()[1] == b'=' {
                let x = (equation.as_bytes()[0] - b'a') as usize;
                let y = (equation.as_bytes()[3] - b'a') as usize;
                union(&mut parent, x, y);
            }
        }

        for equation in &equations {
            if equation.as_bytes()[1] == b'!' {
                let x = (equation.as_bytes()[0] - b'a') as usize;
                let y = (equation.as_bytes()[3] - b'a') as usize;
                if find(&mut parent, x) == find(&mut parent, y) {
                    return false;
                }
            }
        }
        true
    }
}