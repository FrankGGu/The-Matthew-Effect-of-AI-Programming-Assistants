use std::collections::HashMap;

pub fn smallest_equivalent_string(s1: String, s2: String, base_str: String) -> String {
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

    for (a, b) in s1.chars().zip(s2.chars()) {
        union(&mut parent, (a as usize - 'a' as usize), (b as usize - 'a' as usize));
    }

    let mut mapping = vec![' '; 26];
    for i in 0..26 {
        let root = find(&mut parent, i);
        if mapping[root] == ' ' || mapping[root] > (i as u8 + 'a' as u8) as char {
            mapping[root] = (i as u8 + 'a' as u8) as char;
        }
    }

    base_str.chars().map(|c| mapping[find(&mut parent, (c as usize - 'a' as usize))]).collect()
}