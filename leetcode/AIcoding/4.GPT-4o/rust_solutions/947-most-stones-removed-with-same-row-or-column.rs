pub fn remove_stones(stones: Vec<Vec<i32>>) -> i32 {
    use std::collections::HashSet;

    let mut parent = vec![-1; stones.len()];

    fn find(parent: &mut Vec<i32>, x: usize) -> usize {
        if parent[x] < 0 {
            return x;
        }
        let root = find(parent, parent[x] as usize);
        parent[x] = root as i32;
        root
    }

    fn union(parent: &mut Vec<i32>, x: usize, y: usize) {
        let root_x = find(parent, x);
        let root_y = find(parent, y);
        if root_x != root_y {
            parent[root_x] = root_y as i32;
        }
    }

    let mut row_map = std::collections::HashMap::new();
    let mut col_map = std::collections::HashMap::new();

    for (i, stone) in stones.iter().enumerate() {
        let (r, c) = (stone[0], stone[1]);
        row_map.entry(r).or_insert(vec![]).push(i);
        col_map.entry(c).or_insert(vec![]).push(i);
    }

    for indices in row_map.values() {
        let first = indices[0];
        for &index in indices.iter().skip(1) {
            union(&mut parent, first, index);
        }
    }

    for indices in col_map.values() {
        let first = indices[0];
        for &index in indices.iter().skip(1) {
            union(&mut parent, first, index);
        }
    }

    let mut unique_roots = HashSet::new();
    for i in 0..stones.len() {
        unique_roots.insert(find(&mut parent, i));
    }

    stones.len() as i32 - unique_roots.len() as i32
}