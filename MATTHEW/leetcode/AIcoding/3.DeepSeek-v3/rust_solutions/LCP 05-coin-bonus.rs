struct Solution;

impl Solution {
    pub fn bonus(mut n: i32, leadership: Vec<Vec<i32>>, operations: Vec<Vec<i32>>) -> Vec<i32> {
        let mut tree = vec![vec![]; (n + 1) as usize];
        for edge in leadership {
            let parent = edge[0] as usize;
            let child = edge[1] as usize;
            tree[parent].push(child);
        }

        let mut in_time = vec![0; (n + 1) as usize];
        let mut out_time = vec![0; (n + 1) as usize];
        let mut time = 0;

        Self::dfs(1, &tree, &mut in_time, &mut out_time, &mut time);

        let mut fenwick = FenwickTree::new(n as usize + 2);
        let mut res = vec![];
        for op in operations {
            match op[0] {
                1 => {
                    let u = op[1] as usize;
                    fenwick.add(in_time[u], op[2]);
                }
                2 => {
                    let u = op[1] as usize;
                    let l = in_time[u];
                    let r = out_time[u];
                    fenwick.add_range(l, r, op[2]);
                }
                3 => {
                    let u = op[1] as usize;
                    let l = in_time[u];
                    let r = out_time[u];
                    let sum = fenwick.sum_range(l, r);
                    res.push((sum % 1_000_000_007) as i32);
                }
                _ => unreachable!(),
            }
        }
        res
    }

    fn dfs(u: usize, tree: &Vec<Vec<usize>>, in_time: &mut Vec<i32>, out_time: &mut Vec<i32>, time: &mut i32) {
        *time += 1;
        in_time[u] = *time;
        for &v in &tree[u] {
            Self::dfs(v, tree, in_time, out_time, time);
        }
        out_time[u] = *time;
    }
}

struct FenwickTree {
    size: usize,
    data: Vec<i64>,
}

impl FenwickTree {
    fn new(size: usize) -> Self {
        FenwickTree {
            size,
            data: vec![0; size + 1],
        }
    }

    fn add(&mut self, mut idx: i32, delta: i32) {
        let delta = delta as i64;
        while idx <= self.size as i32 {
            self.data[idx as usize] += delta;
            idx += idx & -idx;
        }
    }

    fn sum(&self, mut idx: i32) -> i64 {
        let mut res = 0;
        while idx > 0 {
            res += self.data[idx as usize];
            idx -= idx & -idx;
        }
        res
    }

    fn add_range(&mut self, l: i32, r: i32, delta: i32) {
        self.add(l, delta);
        self.add(r + 1, -delta);
    }

    fn sum_range(&self, l: i32, r: i32) -> i64 {
        self.sum(r) - self.sum(l - 1)
    }
}