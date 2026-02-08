use std::collections::HashSet;

impl Solution {
    pub fn powerful_integers(x: i32, y: i32, bound: i32) -> Vec<i32> {
        let mut powerful_nums: HashSet<i32> = HashSet::new();

        let mut val1 = 1;
        loop {
            if val1 > bound {
                break;
            }

            let mut val2 = 1;
            loop {
                let sum = val1 + val2;
                if sum > bound {
                    break;
                }
                powerful_nums.insert(sum);

                if y == 1 {
                    break;
                }
                val2 *= y;
            }

            if x == 1 {
                break;
            }
            val1 *= x;
        }

        powerful_nums.into_iter().collect()
    }
}