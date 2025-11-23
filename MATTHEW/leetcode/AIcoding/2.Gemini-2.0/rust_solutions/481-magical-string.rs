impl Solution {
    pub fn magical_string(n: i32) -> i32 {
        if n <= 0 {
            return 0;
        }
        if n <= 3 {
            return 1;
        }

        let n = n as usize;
        let mut s = vec![1, 2, 2];
        let mut i = 2;
        let mut j = 3;
        while j < n {
            let count = s[i];
            let num = if s[j - 1] == 1 { 2 } else { 1 };
            for _ in 0..count {
                if j < n {
                    s.push(num);
                    j += 1;
                }
            }
            i += 1;
        }

        s.iter().take(n).filter(|&x| *x == 1).count() as i32
    }
}