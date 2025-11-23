impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn postsort(arr: Vec<i32>, k: i32) -> i32 {
        let n = arr.len();
        let mut dp = vec![vec![0; k as usize + 1]; n];
        let mut memo = HashMap::new();

        fn dfs(
            arr: &[i32],
            index: usize,
            max_val: i32,
            k: i32,
            memo: &mut HashMap<(usize, i32, i32), i32>,
        ) -> i32 {
            if k < 0 {
                return 0;
            }
            if index == arr.len() {
                return 1;
            }
            if let Some(&res) = memo.get(&(index, max_val, k)) {
                return res;
            }

            let mut res = 0;
            for i in 0..arr.len() {
                if arr[i] > max_val {
                    res += dfs(arr, index + 1, arr[i], k - 1, memo);
                } else {
                    res += dfs(arr, index + 1, max_val, k, memo);
                }
            }

            memo.insert((index, max_val, k), res);
            res
        }

        dfs(&arr, 0, -1, k, &mut memo)
    }
}
}