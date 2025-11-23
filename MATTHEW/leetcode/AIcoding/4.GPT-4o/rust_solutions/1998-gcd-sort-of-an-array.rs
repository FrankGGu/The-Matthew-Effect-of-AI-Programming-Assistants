use std::collections::HashSet;

impl Solution {
    pub fn gcd_sort(nums: Vec<i32>) -> bool {
        let mut nums_sorted = nums.clone();
        nums_sorted.sort();
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
                parent[root_x] = root_y;
            }
        }

        for &num in &nums {
            for i in 1..=((num as f32).sqrt() as usize) {
                if num % i == 0 {
                    union(&mut parent, num as usize, i);
                    union(&mut parent, num as usize, (num / i) as usize);
                }
            }
        }

        let mut component_map: HashSet<usize> = HashSet::new();
        for &num in &nums {
            component_map.insert(find(&mut parent, num as usize));
        }

        let mut components: Vec<Vec<i32>> = vec![vec![]; component_map.len()];
        let mut index = 0;
        for &num in &nums {
            let root = find(&mut parent, num as usize);
            components[root].push(num);
        }

        for component in components {
            let mut sorted_component = component.clone();
            sorted_component.sort();
            for (i, num) in component.iter().enumerate() {
                if *num != sorted_component[i] {
                    return false;
                }
            }
        }

        true
    }
}