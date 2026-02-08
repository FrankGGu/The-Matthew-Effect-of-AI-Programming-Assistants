impl Solution {
    pub fn find_latest_group(arr: Vec<i32>, m: i32) -> i32 {
        let n = arr.len();
        if m as usize > n {
            return -1;
        }
        if m as usize == n {
            return n as i32;
        }

        let mut parent: Vec<i32> = (0..=n).map(|i| i as i32).collect();
        let mut size: Vec<i32> = vec![0; n + 1];
        let mut ones: Vec<i32> = vec![0; n + 1];
        let mut ans = -1;

        fn find(parent: &mut Vec<i32>, i: usize) -> usize {
            if parent[i] as usize != i {
                parent[i] = find(parent, parent[i] as usize) as i32;
            }
            parent[i] as usize
        }

        fn union(parent: &mut Vec<i32>, size: &mut Vec<i32>, a: usize, b: usize) {
            let root_a = find(parent, a);
            let root_b = find(parent, b);
            if root_a != root_b {
                if size[root_a] < size[root_b] {
                    parent[root_a] = root_b as i32;
                    size[root_b] += size[root_a];
                } else {
                    parent[root_b] = root_a as i32;
                    size[root_a] += size[root_b];
                }
            }
        }

        for (i, &val) in arr.iter().enumerate() {
            let idx = val as usize;
            ones[idx] = 1;
            size[idx] = 1;

            if idx > 1 && ones[idx - 1] == 1 {
                union(&mut parent, &mut size, idx - 1, idx);
            }
            if idx < n && ones[idx + 1] == 1 {
                union(&mut parent, &mut size, idx, idx + 1);
            }

            let root = find(&mut parent, idx);
            if size[root] == m {
                ans = (i + 1) as i32;
            }
        }

        ans
    }
}