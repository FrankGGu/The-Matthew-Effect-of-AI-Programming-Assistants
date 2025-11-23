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
        let mut res = 1;
        while tail < n {
            for _ in 0..s[head] {
                s[tail] = num;
                if num == 1 && tail < n {
                    res += 1;
                }
                tail += 1;
                if tail >= n {
                    break;
                }
            }
            num ^= 3;
            head += 1;
        }
        res
    }
}