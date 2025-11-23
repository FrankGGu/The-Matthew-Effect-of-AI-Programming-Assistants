use std::collections::HashSet;

impl Solution {
    pub fn powerful_integers(x: i32, y: i32, bound: i32) -> Vec<i32> {
        let mut res = HashSet::new();
        let mut i = 0;
        loop {
            let x_pow = x.pow(i);
            if x_pow >= bound {
                break;
            }
            let mut j = 0;
            loop {
                let sum = x_pow + y.pow(j);
                if sum > bound {
                    break;
                }
                res.insert(sum);
                if y == 1 {
                    break;
                }
                j += 1;
            }
            if x == 1 {
                break;
            }
            i += 1;
        }
        let mut res_vec: Vec<i32> = res.into_iter().collect();
        res_vec.sort();
        res_vec
    }
}