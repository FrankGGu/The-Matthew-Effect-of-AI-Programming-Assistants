impl Solution {
    pub fn make_array_increasing(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let mut arr2 = arr2;
        arr2.sort();
        let mut dp = std::collections::HashMap::new();
        dp.insert(0, 0);

        for &a in &arr1 {
            let mut new_dp = std::collections::HashMap::new();
            for (&key, &val) in &dp {
                if a > key {
                    new_dp.insert(a, val);
                }
                if let Ok(pos) = arr2.binary_search(&(key + 1)) {
                    new_dp.insert(arr2[pos], val + 1);
                } else {
                    let pos = arr2.iter().position(|&x| x > key).unwrap_or(arr2.len());
                    if pos < arr2.len() {
                        new_dp.insert(arr2[pos], val + 1);
                    }
                }
            }
            dp = new_dp;
        }

        *dp.values().map(|&x| x).min().unwrap_or(i32::MAX)
    }
}