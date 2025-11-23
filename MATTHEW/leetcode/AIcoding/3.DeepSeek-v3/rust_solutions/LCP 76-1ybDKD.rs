impl Solution {
    pub fn magical_string(n: i32) -> i32 {
        if n == 0 {
            return 0;
        }
        if n <= 3 {
            return 1;
        }
        let n = n as usize;
        let mut s = vec![0; n + 1];
        s[0] = 1;
        s[1] = 2;
        s[2] = 2;
        let mut head = 2;
        let mut tail = 3;
        let mut num = 1;
        let mut result = 1;
        while tail < n {
            for _ in 0..s[head] {
                if tail < n && num == 1 {
                    result += 1;
                }
                s[tail] = num;
                tail += 1;
            }
            num ^= 3;
            head += 1;
        }
        result
    }
}