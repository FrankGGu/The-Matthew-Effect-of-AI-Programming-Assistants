use std::collections::BTreeMap;

impl Solution {
    pub fn maximum_sum_queries(nums1: Vec<i32>, nums2: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut pairs: Vec<(i32, i32)> = nums1.into_iter().zip(nums2.into_iter()).collect();
        pairs.sort_by(|a, b| b.0.cmp(&a.0).then_with(|| b.1.cmp(&a.1)));

        let mut queries_with_index: Vec<(i32, i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q[0], q[1], i))
            .collect();
        queries_with_index.sort_by(|a, b| b.0.cmp(&a.0).then_with(|| b.1.cmp(&a.1)));

        let mut res = vec![-1; queries_with_index.len()];
        let mut btm: BTreeMap<i32, i32> = BTreeMap::new();
        let mut pair_ptr = 0;

        for (x, y, idx) in queries_with_index {
            while pair_ptr < pairs.len() && pairs[pair_ptr].0 >= x {
                let (a, b) = pairs[pair_ptr];
                let sum = a + b;
                if let Some(&s) = btm.range(b..).next() {
                    if s >= sum {
                        continue;
                    }
                }
                while let Some((&k, &v)) = btm.range(..=b).next_back() {
                    if v <= sum {
                        btm.remove(&k);
                    } else {
                        break;
                    }
                }
                btm.insert(b, sum);
                pair_ptr += 1;
            }
            if let Some((_, &s)) = btm.range(y..).next() {
                res[idx] = s;
            }
        }

        res
    }
}