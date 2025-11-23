impl Solution {
    pub fn product_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut result = Vec::new();
        for query in queries {
            let (x, y, mod_val) = (query[0] as usize, query[1] as usize, query[2] as i64);
            let mut product = 1i64;
            for i in x..=y {
                let mut num = i;
                while num > 0 {
                    let lsb = num & (!num + 1);
                    product = (product * lsb as i64) % mod_val;
                    num -= lsb;
                }
            }
            result.push((product % mod_val) as i32);
        }
        result
    }
}