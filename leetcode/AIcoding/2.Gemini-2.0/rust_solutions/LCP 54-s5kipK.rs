impl Solution {
    pub fn capture_forts(forts: Vec<i32>) -> i32 {
        let n = forts.len();
        let mut max_len = 0;
        let mut last = -1;

        for i in 0..n {
            if forts[i] != 0 {
                if last != -1 && forts[i] != forts[last] {
                    max_len = max_len.max((i - last - 1) as i32);
                }
                last = i as i32;
            }
        }

        max_len
    }
}