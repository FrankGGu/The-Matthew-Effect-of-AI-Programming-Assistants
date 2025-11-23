impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        if n == 0 {
            return 0;
        }
        let m = strs[0].len();
        let mut count = 0;
        for j in 0..m {
            for i in 1..n {
                if strs[i].as_bytes()[j] < strs[i-1].as_bytes()[j] {
                    count += 1;
                    break;
                }
            }
        }
        count
    }
}