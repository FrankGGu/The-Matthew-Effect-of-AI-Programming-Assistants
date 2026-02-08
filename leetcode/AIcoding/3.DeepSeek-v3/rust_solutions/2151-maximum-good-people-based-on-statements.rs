impl Solution {
    pub fn maximum_good(statements: Vec<Vec<i32>>) -> i32 {
        let n = statements.len();
        let mut max_good = 0;

        for mask in 0..(1 << n) {
            let mut valid = true;
            for i in 0..n {
                if (mask & (1 << i)) != 0 {
                    for j in 0..n {
                        if statements[i][j] != 2 && statements[i][j] != ((mask >> j) & 1) {
                            valid = false;
                            break;
                        }
                    }
                }
                if !valid {
                    break;
                }
            }
            if valid {
                max_good = max_good.max(mask.count_ones() as i32);
            }
        }

        max_good
    }
}