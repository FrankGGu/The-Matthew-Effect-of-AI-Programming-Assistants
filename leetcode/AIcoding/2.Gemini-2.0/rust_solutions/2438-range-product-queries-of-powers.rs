impl Solution {
    pub fn product_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut powers: Vec<i32> = Vec::new();
        let mut num = n;
        let mut power = 0;
        while num > 0 {
            if num % 2 == 1 {
                powers.push(1 << power);
            }
            num /= 2;
            power += 1;
        }

        let mut result: Vec<i32> = Vec::new();
        let modulo: i64 = 1000000007;

        for query in queries {
            let start = query[0] as usize;
            let end = query[1] as usize;
            let mut product: i64 = 1;
            for i in start..=end {
                product = (product * powers[i] as i64) % modulo;
            }
            result.push(product as i32);
        }

        result
    }
}