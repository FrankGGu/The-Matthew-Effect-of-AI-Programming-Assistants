use std::collections::HashSet;

pub fn num_squareful_permutations(a: Vec<i32>) -> i32 {
    let mut a = a;
    a.sort();
    let mut count = 0;
    let mut used = vec![false; a.len()];
    let mut path = vec![];

    fn is_squareful(x: i32, y: i32) -> bool {
        let sum = x + y;
        (sum as f64).sqrt().fract() == 0.0
    }

    fn backtrack(a: &Vec<i32>, used: &mut Vec<bool>, path: &mut Vec<i32>, count: &mut i32) {
        if path.len() == a.len() {
            *count += 1;
            return;
        }

        for i in 0..a.len() {
            if used[i] || (i > 0 && a[i] == a[i - 1] && !used[i - 1]) {
                continue;
            }
            if path.is_empty() || is_squareful(*path.last().unwrap(), a[i]) {
                used[i] = true;
                path.push(a[i]);
                backtrack(a, used, path, count);
                path.pop();
                used[i] = false;
            }
        }
    }

    backtrack(&a, &mut used, &mut path, &mut count);
    count
}