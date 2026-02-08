use std::collections::HashMap;

impl Solution {
    pub fn min_operations(target: Vec<i32>, arr: Vec<i32>) -> i32 {
        let pos: HashMap<_, _> = target.iter().enumerate().map(|(i, &x)| (x, i)).collect();
        let mut lis = Vec::new();
        for &num in arr.iter() {
            if let Some(&idx) = pos.get(&num) {
                if let Err(i) = lis.binary_search(&idx) {
                    if i == lis.len() {
                        lis.push(idx);
                    } else {
                        lis[i] = idx;
                    }
                }
            }
        }
        (target.len() - lis.len()) as i32
    }
}