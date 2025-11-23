impl Solution {
    pub fn maximum_good_people(statements: Vec<Vec<i32>>) -> i32 {
        let n = statements.len();
        let mut max_good_people = 0;

        for mask in 0..(1 << n) {
            let mut current_good_people_count = 0;
            let mut is_consistent = true;

            for i in 0..n {
                if ((mask >> i) & 1) == 1 {
                    current_good_people_count += 1;
                }
            }

            for i in 0..n {
                if ((mask >> i) & 1) == 1 {
                    for j in 0..n {
                        if statements[i][j] != 2 {
                            if statements[i][j] == 0 {
                                if ((mask >> j) & 1) == 1 {
                                    is_consistent = false;
                                    break;
                                }
                            } else {
                                if ((mask >> j) & 1) == 0 {
                                    is_consistent = false;
                                    break;
                                }
                            }
                        }
                    }
                }
                if !is_consistent {
                    break;
                }
            }

            if is_consistent {
                max_good_people = max_good_people.max(current_good_people_count);
            }
        }

        max_good_people
    }
}