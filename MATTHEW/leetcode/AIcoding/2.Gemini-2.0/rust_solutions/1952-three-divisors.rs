impl Solution {
    pub fn is_three(n: i32) -> bool {
        if n <= 2 {
            return false;
        }
        let mut count = 0;
        let mut i = 1;
        while i * i <= n {
            if n % i == 0 {
                if i * i == n {
                    count += 1;
                } else {
                    count += 2;
                }
            }
            i += 1;
        }
        count == 3
    }
}