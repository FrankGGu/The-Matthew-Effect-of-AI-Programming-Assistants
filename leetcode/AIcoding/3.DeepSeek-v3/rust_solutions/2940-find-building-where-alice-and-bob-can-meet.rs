impl Solution {
    pub fn leftmost_building_queries(heights: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = heights.len();
        let mut res = vec![-1; queries.len()];
        let mut stack: Vec<(i32, usize)> = Vec::new();
        let mut queries_with_indices: Vec<_> = queries.into_iter().enumerate().collect();

        queries_with_indices.sort_by(|a, b| {
            let a_left = a.1[0].min(a.1[1]) as usize;
            let a_right = a.1[0].max(a.1[1]) as usize;
            let b_left = b.1[0].min(b.1[1]) as usize;
            let b_right = b.1[0].max(b.1[1]) as usize;
            b_right.cmp(&a_right).then(b_left.cmp(&a_left))
        });

        let mut idx = n - 1;
        for (query_idx, query) in queries_with_indices {
            let (a, b) = (query[0] as usize, query[1] as usize);
            let (left, right) = if a < b { (a, b) } else { (b, a) };

            if left == right || heights[left] < heights[right] {
                res[query_idx] = right as i32;
                continue;
            }

            while idx >= right {
                while !stack.is_empty() && stack.last().unwrap().0 <= heights[idx] {
                    stack.pop();
                }
                stack.push((heights[idx], idx));
                idx -= 1;
            }

            let pos = stack.binary_search_by(|&(h, _)| h.cmp(&heights[left]).then(std::cmp::Ordering::Greater));
            if let Ok(i) = pos {
                if i < stack.len() {
                    res[query_idx] = stack[i].1 as i32;
                }
            } else {
                let i = pos.unwrap_err();
                if i < stack.len() {
                    res[query_idx] = stack[i].1 as i32;
                }
            }
        }

        res
    }
}