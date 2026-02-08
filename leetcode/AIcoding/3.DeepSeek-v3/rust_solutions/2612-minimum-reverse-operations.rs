use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn min_reverse_operations(n: i32, p: i32, banned: Vec<i32>, k: i32) -> Vec<i32> {
        let n = n as usize;
        let p = p as usize;
        let k = k as usize;
        let mut banned_set: HashSet<usize> = banned.into_iter().map(|x| x as usize).collect();
        let mut res = vec![-1; n];
        let mut queue = VecDeque::new();

        if !banned_set.contains(&p) {
            res[p] = 0;
            queue.push_back(p);
        }

        let mut available = [HashSet::new(), HashSet::new()];
        for i in 0..n {
            if !banned_set.contains(&i) && i != p {
                available[i % 2].insert(i);
            }
        }

        while let Some(u) = queue.pop_front() {
            let min_l = if u >= k - 1 { u - (k - 1) } else { 0 };
            let max_l = u.min(n - k);

            let left = 2 * max_l + k - 1 - u;
            let right = 2 * min_l + k - 1 - u;

            let parity = (left % 2) as usize;
            let mut to_remove = Vec::new();

            let mut current = left;
            while current >= right {
                if available[parity].contains(&current) {
                    res[current] = res[u] + 1;
                    queue.push_back(current);
                    to_remove.push(current);
                }
                current = current.saturating_sub(2);
            }

            for &v in &to_remove {
                available[parity].remove(&v);
            }
        }

        res
    }
}