impl Solution {
    pub fn base_neg2(n: i32) -> String {
        if n == 0 {
            return "0".to_string();
        }

        let mut n = n;
        let mut result = Vec::new();

        while n != 0 {
            let remainder = n % -2;
            n /= -2;
            if remainder < 0 {
                remainder += 2;
                n += 1;
            }
            result.push(remainder);
        }

        result.reverse();
        result.iter().map(|x| x.to_string()).collect()
    }
}