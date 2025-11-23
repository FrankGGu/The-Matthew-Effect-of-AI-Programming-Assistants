impl Solution {
    pub fn find_min_fibonacci_numbers(mut k: i32) -> i32 {
        let mut fibs = vec![1, 1];
        while *fibs.last().unwrap() <= k {
            let next = fibs[fibs.len() - 1] + fibs[fibs.len() - 2];
            fibs.push(next);
        }
        let mut count = 0;
        let mut i = fibs.len() - 1;
        while k > 0 {
            if fibs[i] <= k {
                k -= fibs[i];
                count += 1;
            }
            i -= 1;
        }
        count
    }
}