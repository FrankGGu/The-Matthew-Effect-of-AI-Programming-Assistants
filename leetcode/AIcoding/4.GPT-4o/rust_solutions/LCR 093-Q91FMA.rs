impl Solution {
    pub fn len_longest_fib_subseq(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut indices = std::collections::HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            indices.insert(num, i);
        }

        let mut max_len = 0;
        let mut dp = std::collections::HashMap::new();

        for j in 1..n {
            for i in 0..j {
                let sum = arr[i] + arr[j];
                if let Some(&k) = indices.get(&sum) {
                    if k > j {
                        let len = dp.get(&(i, j)).unwrap_or(&2) + 1;
                        dp.insert((j, k), len);
                        max_len = max_len.max(len);
                    }
                }
            }
        }

        if max_len >= 3 { max_len } else { 0 }
    }
}