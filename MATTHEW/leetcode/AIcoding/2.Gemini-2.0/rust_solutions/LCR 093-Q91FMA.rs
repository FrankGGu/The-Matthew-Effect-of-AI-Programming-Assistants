use std::collections::HashSet;

impl Solution {
    pub fn len_longest_fib_subseq(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let set: HashSet<i32> = arr.iter().cloned().collect();
        let mut ans = 0;

        for i in 0..n {
            for j in i + 1..n {
                let mut a = arr[i];
                let mut b = arr[j];
                let mut len = 2;

                while set.contains(&(a + b)) {
                    let temp = b;
                    b = a + b;
                    a = temp;
                    len += 1;
                }

                ans = ans.max(len);
            }
        }

        if ans > 2 {
            ans
        } else {
            0
        }
    }
}