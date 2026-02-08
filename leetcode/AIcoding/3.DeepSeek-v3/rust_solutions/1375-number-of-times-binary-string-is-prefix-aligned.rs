impl Solution {
    pub fn num_times_prefix_aligned(flips: Vec<i32>) -> i32 {
        let mut max = 0;
        let mut res = 0;
        for (i, &num) in flips.iter().enumerate() {
            if num > max {
                max = num;
            }
            if max == (i + 1) as i32 {
                res += 1;
            }
        }
        res
    }
}