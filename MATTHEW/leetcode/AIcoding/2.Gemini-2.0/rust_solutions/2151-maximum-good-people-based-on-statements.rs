impl Solution {
    pub fn maximum_good(statements: Vec<Vec<i32>>) -> i32 {
        let n = statements.len();
        let mut max_good = 0;

        for mask in 0..(1 << n) {
            let mut good_count = 0;
            let mut consistent = true;

            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    good_count += 1;
                    for j in 0..n {
                        if statements[i][j] != 2 {
                            let expected = ((mask >> j) & 1) as i32;
                            if statements[i][j] != expected {
                                consistent = false;
                                break;
                            }
                        }
                    }
                }
                if !consistent {
                    break;
                }
            }

            if consistent {
                max_good = max_good.max(good_count);
            }
        }

        max_good
    }
}