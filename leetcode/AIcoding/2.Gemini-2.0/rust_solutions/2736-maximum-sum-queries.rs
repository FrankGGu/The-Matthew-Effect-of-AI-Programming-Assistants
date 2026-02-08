impl Solution {
    pub fn maximum_sum_queries(nums1: Vec<i32>, nums2: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums1.len();
        let m = queries.len();
        let mut pairs: Vec<(i32, i32)> = nums1.iter().zip(nums2.iter()).map(|(&x, &y)| (x, y)).collect();
        pairs.sort_by(|a, b| b.0.cmp(&a.0));

        let mut queries_with_index: Vec<(i32, i32, usize)> = queries.iter().enumerate().map(|(i, q)| (q[0], q[1], i)).collect();
        queries_with_index.sort_by(|a, b| b.0.cmp(&a.0));

        let mut ans = vec![-1; m];
        let mut stack: Vec<(i32, i32)> = Vec::new();
        let mut j = 0;

        for &(x, y, i) in &queries_with_index {
            while j < n && pairs[j].0 >= x {
                let a = pairs[j].0;
                let b = pairs[j].1;
                while !stack.is_empty() && stack.last().unwrap().1 <= b {
                    stack.pop();
                }
                if stack.is_empty() || stack.last().unwrap().1 > b {
                    stack.push((a, b));
                }
                j += 1;
            }

            let mut max_sum = -1;
            for &(a, b) in &stack {
                if b >= y {
                    max_sum = max_sum.max(a + b);
                }
            }
            ans[i] = max_sum;
        }

        ans
    }
}