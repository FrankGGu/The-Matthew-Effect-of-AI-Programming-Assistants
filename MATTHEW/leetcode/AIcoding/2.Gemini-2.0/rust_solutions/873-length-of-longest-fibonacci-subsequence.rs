use std::collections::HashMap;

impl Solution {
    pub fn len_longest_fib_subseq(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut index_map: HashMap<i32, usize> = HashMap::new();
        for i in 0..n {
            index_map.insert(arr[i], i);
        }

        let mut longest = 0;
        for i in 0..n {
            for j in (i + 1)..n {
                let mut a = arr[i];
                let mut b = arr[j];
                let mut len = 2;

                while let Some(&k) = index_map.get(&(a + b)) {
                    a = b;
                    b = arr[k];
                    len += 1;
                }

                longest = longest.max(len);
            }
        }

        if longest > 2 {
            longest
        } else {
            0
        }
    }
}