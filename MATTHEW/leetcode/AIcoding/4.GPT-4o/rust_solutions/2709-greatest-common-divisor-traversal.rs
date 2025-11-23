use std::collections::HashSet;

impl Solution {
    pub fn gcd_traversal(arr: Vec<i32>) -> bool {
        let n = arr.len();
        let mut visited = HashSet::new();
        let mut stack = vec![0];

        while let Some(idx) = stack.pop() {
            if visited.insert(idx) {
                for i in 0..n {
                    if !visited.contains(&i) && Self::gcd(arr[idx], arr[i]) > 1 {
                        stack.push(i);
                    }
                }
            }
        }

        visited.len() == n
    }

    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }
}