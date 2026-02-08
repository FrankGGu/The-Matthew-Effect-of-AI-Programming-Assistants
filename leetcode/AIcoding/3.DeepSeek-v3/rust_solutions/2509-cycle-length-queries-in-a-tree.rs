impl Solution {
    pub fn cycle_length_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        queries.into_iter().map(|query| {
            let (mut a, mut b) = (query[0], query[1]);
            let mut res = 1;
            while a != b {
                if a > b {
                    a /= 2;
                } else {
                    b /= 2;
                }
                res += 1;
            }
            res
        }).collect()
    }
}