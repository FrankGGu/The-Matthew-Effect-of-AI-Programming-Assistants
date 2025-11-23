impl Solution {
    pub fn recover_array(n: i32, sums: Vec<i32>) -> Vec<i32> {
        let mut sums = sums;
        sums.sort_unstable();
        let mut res = Vec::new();
        for _ in 0..n {
            let diff = sums[1] - sums[0];
            res.push(diff);
            let mut pos = 0;
            let mut seen = std::collections::HashSet::new();
            let mut next_sums = Vec::new();
            for &x in &sums {
                if seen.contains(&x) {
                    seen.remove(&x);
                } else {
                    next_sums.push(x);
                    seen.insert(x + diff);
                }
            }
            if next_sums.len() * 2 == sums.len() && next_sums[0] == sums[0] {
                sums = next_sums;
            } else {
                res.pop();
                res.push(-diff);
                let mut pos = 0;
                let mut seen = std::collections::HashSet::new();
                let mut next_sums = Vec::new();
                for &x in &sums {
                    if seen.contains(&x) {
                        seen.remove(&x);
                    } else {
                        next_sums.push(x);
                        seen.insert(x - diff);
                    }
                }
                sums = next_sums;
            }
        }
        res
    }
}