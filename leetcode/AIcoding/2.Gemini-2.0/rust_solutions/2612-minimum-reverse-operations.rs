use std::collections::VecDeque;

impl Solution {
    pub fn minimum_reverse_operations(n: i32, p: i32, banned: Vec<i32>, k: i32) -> Vec<i32> {
        let n = n as usize;
        let p = p as usize;
        let k = k as usize;
        let mut banned_set = std::collections::HashSet::new();
        for &b in &banned {
            banned_set.insert(b as usize);
        }

        let mut ans = vec![-1; n];
        let mut q = VecDeque::new();

        if !banned_set.contains(&p) {
            ans[p] = 0;
            q.push_back(p);
        }

        let mut even = std::collections::BTreeSet::new();
        let mut odd = std::collections::BTreeSet::new();

        for i in 0..n {
            if i % 2 == 0 && i != p && !banned_set.contains(&i) {
                even.insert(i);
            } else if i % 2 != 0 && i != p && !banned_set.contains(&i) {
                odd.insert(i);
            }
        }

        while let Some(u) = q.pop_front() {
            let dist = ans[u];
            let lower = (k - 1).max(u) - (k - 1).min(u);
            let upper = (2 * n).saturating_sub(k + 1).min(u + k - 1) - (k - 1).min(u);

            let mut to_visit = vec![];
            if u % 2 == 0 {
                for &v in even.range(lower..=upper) {
                    to_visit.push(v);
                }
                for &v in &to_visit {
                    even.remove(&v);
                }

            } else {
                for &v in odd.range(lower..=upper) {
                    to_visit.push(v);
                }
                for &v in &to_visit {
                    odd.remove(&v);
                }
            }

            for v in to_visit {
                ans[v] = dist + 1;
                q.push_back(v);
            }
        }
        ans
    }
}