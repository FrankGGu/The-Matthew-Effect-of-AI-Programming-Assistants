impl Solution {
    pub fn smallest_string(s: String, operations: Vec<Vec<i32>>) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut parent = (0..n).collect::<Vec<usize>>();

        fn find(parent: &mut Vec<usize>, x: usize) -> usize {
            if parent[x] != x {
                parent[x] = find(parent, parent[x]);
            }
            parent[x]
        }

        for op in operations {
            let (x, y) = (op[0] as usize, op[1] as usize);
            let root_x = find(&mut parent, x);
            let root_y = find(&mut parent, y);
            if root_x != root_y {
                parent[root_y] = root_x;
            }
        }

        let mut groups = vec![vec![]; n];
        for i in 0..n {
            let root = find(&mut parent, i);
            groups[root].push(i);
        }

        for group in groups {
            if !group.is_empty() {
                let mut chars: Vec<char> = group.iter().map(|&i| s[i]).collect();
                chars.sort();
                for (i, &index) in group.iter().enumerate() {
                    s[index] = chars[i];
                }
            }
        }

        s.iter().collect()
    }
}