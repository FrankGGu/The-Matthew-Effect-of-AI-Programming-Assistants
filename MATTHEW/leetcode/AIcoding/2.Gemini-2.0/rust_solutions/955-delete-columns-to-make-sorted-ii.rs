impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let m = strs[0].len();
        let mut ans = 0;
        let mut sorted = vec![false; n - 1];

        for j in 0..m {
            let mut need_delete = false;
            for i in 0..n - 1 {
                if !sorted[i] && strs[i].as_bytes()[j] > strs[i + 1].as_bytes()[j] {
                    need_delete = true;
                    break;
                }
            }

            if need_delete {
                ans += 1;
            } else {
                for i in 0..n - 1 {
                    if strs[i].as_bytes()[j] < strs[i + 1].as_bytes()[j] {
                        sorted[i] = true;
                    }
                }
            }
        }

        ans
    }
}