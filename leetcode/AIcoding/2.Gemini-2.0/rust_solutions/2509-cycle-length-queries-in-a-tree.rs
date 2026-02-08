impl Solution {
    pub fn cycle_length_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        for query in queries {
            let mut a = query[0];
            let mut b = query[1];
            let mut length = 1;
            while a != b {
                if a > b {
                    a /= 2;
                } else {
                    b /= 2;
                }
                length += 1;
            }
            result.push(length);
        }
        result
    }
}