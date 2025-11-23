impl Solution {
    const MODULO: i64 = 1_000_000_007;

    fn power(mut base: i64, mut exp: i64) -> i64 {
        let mut res = 1;
        base %= Self::MODULO;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % Self::MODULO;
            }
            base = (base * base) % Self::MODULO;
            exp /= 2;
        }
        res
    }

    pub fn product_queries(n: i32, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut powers: Vec<i64> = Vec::new();
        let mut temp_n = n as i64;
        let mut current_power = 1;
        while temp_n > 0 {
            if (temp_n & 1) == 1 {
                powers.push(current_power);
            }
            current_power *= 2;
            temp_n >>= 1;
        }

        let mut prefix_products: Vec<i64> = Vec::with_capacity(powers.len() + 1);
        prefix_products.push(1);

        for &p in powers.iter() {
            let last_product = *prefix_products.last().unwrap();
            prefix_products.push((last_product * p) % Self::MODULO);
        }

        let mut results: Vec<i32> = Vec::with_capacity(queries.len());
        for query in queries.iter() {
            let l = query[0] as usize;
            let r = query[1] as usize;

            let num = prefix_products[r + 1];
            let den_inv = Self::power(prefix_products[l], Self::MODULO - 2);

            let product = (num * den_inv) % Self::MODULO;
            results.push(product as i32);
        }

        results
    }
}