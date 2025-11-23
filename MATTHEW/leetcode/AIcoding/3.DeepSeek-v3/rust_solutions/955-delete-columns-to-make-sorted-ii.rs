impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let mut res = 0;
        let n = strs.len();
        if n <= 1 {
            return 0;
        }
        let m = strs[0].len();
        let mut sorted = vec![false; n - 1];

        for j in 0..m {
            let mut to_delete = false;
            let mut new_sorted = sorted.clone();

            for i in 0..n - 1 {
                if !sorted[i] && strs[i].as_bytes()[j] > strs[i + 1].as_bytes()[j] {
                    to_delete = true;
                    break;
                }
            }

            if to_delete {
                res += 1;
            } else {
                for i in 0..n - 1 {
                    if !sorted[i] && strs[i].as_bytes()[j] < strs[i + 1].as_bytes()[j] {
                        new_sorted[i] = true;
                    }
                }
                sorted = new_sorted;
            }
        }

        res
    }
}