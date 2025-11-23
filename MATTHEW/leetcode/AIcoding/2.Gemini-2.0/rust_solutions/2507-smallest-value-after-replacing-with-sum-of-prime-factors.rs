impl Solution {
    pub fn smallest_value(mut n: i32) -> i32 {
        let mut sum = n;
        while sum >= n {
            n = sum;
            sum = 0;
            let mut i = 2;
            let mut temp = n;
            while i * i <= temp {
                while temp % i == 0 {
                    sum += i;
                    temp /= i;
                }
                i += 1;
            }
            if temp > 1 {
                sum += temp;
            }
            if sum == n {
                return n;
            }
        }
        n
    }
}