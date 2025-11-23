impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn circular_permutation(n: i32, k: i32) -> Vec<i32> {
        let mut result = vec![0];
        let mut visited = HashSet::new();
        visited.insert(0);

        for _ in 0..n {
            let mut next = vec![];
            for &num in &result {
                for i in 0..n {
                    let bit = 1 << i;
                    let neighbor = num ^ bit;
                    if !visited.contains(&neighbor) {
                        next.push(neighbor);
                    }
                }
            }
            for num in next {
                result.push(num);
                visited.insert(num);
            }
        }

        let index = result.iter().position(|&x| x == k as i32).unwrap();
        let mut res = vec![];
        for i in 0..n {
            res.push(result[(index + i) % n]);
        }
        res
    }
}
}