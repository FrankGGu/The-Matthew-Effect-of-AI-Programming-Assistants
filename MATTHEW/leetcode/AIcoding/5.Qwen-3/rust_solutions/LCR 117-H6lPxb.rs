struct Solution;

impl Solution {
    pub fn num_similar_groups(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let mut parent = (0..n).collect::<Vec<_>>();

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

        for i in 0..n {
            for j in i + 1..n {
                let s1 = &strs[i];
                let s2 = &strs[j];
                let mut diff = 0;
                for c1 in s1.chars() {
                    if diff > 2 {
                        break;
                    }
                    if let Some(c2) = s2.chars().next() {
                        if c1 != c2 {
                            diff += 1;
                        }
                        s2 = &s2[1..];
                    }
                }
                if diff <= 2 {
                    union(&mut parent, i, j);
                }
            }
        }

        let mut roots = std::collections::HashSet::new();
        for i in 0..n {
            roots.insert(find(&mut parent, i));
        }

        roots.len() as i32
    }
}