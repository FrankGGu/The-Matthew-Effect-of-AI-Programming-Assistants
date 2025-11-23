impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn maximum_good(people: Vec<Vec<i32>>) -> i32 {
        let n = people.len();
        let mut max_good = 0;

        for mask in 1..(1 << n) {
            let mut is_good = vec![false; n];
            let mut valid = true;

            for i in 0..n {
                if (mask >> i) & 1 == 1 {
                    is_good[i] = true;
                    for j in 0..n {
                        if i != j {
                            if people[i][j] == 1 && !is_good[j] {
                                valid = false;
                                break;
                            } else if people[i][j] == 0 && is_good[j] {
                                valid = false;
                                break;
                            }
                        }
                    }
                    if !valid {
                        break;
                    }
                }
            }

            if valid {
                let count = mask.count_ones() as i32;
                max_good = max_good.max(count);
            }
        }

        max_good
    }
}
}