use std::collections::HashSet;

impl Solution {
    pub fn len_longest_fib_subseq(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let set: HashSet<_> = arr.iter().cloned().collect();
        let mut max_len = 0;

        for i in 0..n {
            for j in i+1..n {
                let mut x = arr[i];
                let mut y = arr[j];
                let mut len = 2;

                while set.contains(&(x + y)) {
                    let next = x + y;
                    x = y;
                    y = next;
                    len += 1;
                }

                if len > max_len && len >= 3 {
                    max_len = len;
                }
            }
        }

        max_len
    }
}