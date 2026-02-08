use std::collections::HashMap;

pub fn largest_component_size(nums: Vec<i32>) -> i32 {
    let max_num = *nums.iter().max().unwrap();
    let mut parent = (0..=max_num).collect::<Vec<_>>();

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
            parent[root_y] = root_x;
        }
    }

    for &num in &nums {
        for j in 2..=(num as f64).sqrt() as usize {
            if num % j == 0 {
                union(&mut parent, num as usize, j);
                union(&mut parent, num as usize, num as usize / j);
            }
        }
    }

    let mut size_map = HashMap::new();
    for &num in &nums {
        let root = find(&mut parent, num as usize);
        *size_map.entry(root).or_insert(0) += 1;
    }

    *size_map.values().max().unwrap() as i32
}