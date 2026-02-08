use std::collections::HashSet;

pub fn minimize_hamming_distance(source: Vec<i32>, target: Vec<i32>, allowed_swaps: Vec<Vec<i32>>) -> i32 {
    let n = source.len();
    let mut parent = (0..n).collect::<Vec<_>>();

    fn find(x: usize, parent: &mut Vec<usize>) -> usize {
        if parent[x] != x {
            parent[x] = find(parent[x], parent);
        }
        parent[x]
    }

    for swap in allowed_swaps {
        let a = swap[0] as usize;
        let b = swap[1] as usize;
        let root_a = find(a, &mut parent);
        let root_b = find(b, &mut parent);
        parent[root_a] = root_b;
    }

    let mut groups: Vec<HashSet<i32>> = vec![HashSet::new(); n];
    for i in 0..n {
        let root = find(i, &mut parent);
        groups[root].insert(source[i]);
    }

    let mut result = 0;
    for i in 0..n {
        if !groups[find(i, &mut parent)].contains(&target[i]) {
            result += 1;
        }
    }

    result
}