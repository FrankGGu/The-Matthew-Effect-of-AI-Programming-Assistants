impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let m = strs[0].len();
        let mut delete_columns = vec![false; m];
        let mut sorted = vec![false; n];

        for j in 0..m {
            let mut current_sorted = true;
            for i in 1..n {
                if delete_columns[j] {
                    continue;
                }
                if sorted[i] {
                    continue;
                }
                if strs[i-1].chars().nth(j) > strs[i].chars().nth(j) {
                    delete_columns[j] = true;
                    current_sorted = false;
                    break;
                }
            }
            if !current_sorted {
                continue;
            }
            for i in 1..n {
                if delete_columns[j] {
                    continue;
                }
                if strs[i-1].chars().nth(j) < strs[i].chars().nth(j) {
                    sorted[i] = true;
                }
            }
        }

        delete_columns.iter().filter(|&&x| x).count() as i32
    }
}