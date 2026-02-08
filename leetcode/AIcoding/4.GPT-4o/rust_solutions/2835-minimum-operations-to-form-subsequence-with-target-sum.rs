impl Solution {
    pub fn min_operations(target: Vec<i32>, arr: Vec<i32>) -> i32 {
        use std::collections::HashMap;
        let target_set: HashMap<_, _> = target.iter().enumerate().map(|(i, &x)| (x, i)).collect();
        let mut lis = Vec::new();

        for num in arr {
            if let Some(&index) = target_set.get(&num) {
                let pos = lis.binary_search(&index).unwrap_or_else(|x| x);
                if pos == lis.len() {
                    lis.push(index);
                } else {
                    lis[pos] = index;
                }
            }
        }

        (target.len() - lis.len()) as i32
    }
}