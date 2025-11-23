impl Solution {
    pub fn num_factored_binary_trees(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut arr = arr;
        arr.sort();
        let mut dp = std::collections::HashMap::new();
        let mut ans = 0;
        let mod_val = 1_000_000_007;

        for i in 0..n {
            dp.insert(arr[i], 1);
            for j in 0..i {
                if arr[i] % arr[j] == 0 {
                    let factor2 = arr[i] / arr[j];
                    if dp.contains_key(&factor2) {
                        let count = (*dp.get(&arr[j]).unwrap() as i64 * *dp.get(&factor2).unwrap() as i64) % mod_val as i64;
                        *dp.entry(arr[i]).or_insert(0) += count as i32;
                        *dp.entry(arr[i]).or_insert(0) %= mod_val;
                    }
                }
            }
            ans += *dp.get(&arr[i]).unwrap();
            ans %= mod_val;
        }

        ans
    }
}