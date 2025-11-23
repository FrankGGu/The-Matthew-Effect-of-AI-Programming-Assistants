impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let mut count = 0;
        let n = strs.len();
        let m = strs[0].len();

        for j in 0..m {
            for i in 1..n {
                if strs[i].chars().nth(j) < strs[i - 1].chars().nth(j) {
                    count += 1;
                    break;
                }
            }
        }

        count
    }
}