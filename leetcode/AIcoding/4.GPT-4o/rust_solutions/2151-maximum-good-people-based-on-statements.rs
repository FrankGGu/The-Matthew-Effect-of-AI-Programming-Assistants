pub fn maximum_good(statements: Vec<Vec<i32>>) -> i32 {
    let n = statements.len();
    let mut max_good = 0;

    for mask in 0..(1 << n) {
        let mut is_good = true;
        let mut good_count = 0;

        for i in 0..n {
            if (mask & (1 << i)) != 0 {
                good_count += 1;
                for j in 0..n {
                    if statements[i][j] == 1 && (mask & (1 << j)) == 0 {
                        is_good = false;
                        break;
                    }
                    if statements[i][j] == 0 && (mask & (1 << j)) != 0 {
                        is_good = false;
                        break;
                    }
                }
            }
            if !is_good {
                break;
            }
        }

        if is_good {
            max_good = max_good.max(good_count);
        }
    }

    max_good
}