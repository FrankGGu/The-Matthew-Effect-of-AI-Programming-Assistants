impl Solution {
    pub fn maximum_sum_of_heights(max_heights: Vec<i32>) -> i64 {
        let n = max_heights.len();
        let mut res = 0;

        for i in 0..n {
            let mut sum = max_heights[i] as i64;
            let mut prev = max_heights[i];

            for j in (0..i).rev() {
                prev = prev.min(max_heights[j]);
                sum += prev as i64;
            }

            prev = max_heights[i];
            for j in i+1..n {
                prev = prev.min(max_heights[j]);
                sum += prev as i64;
            }

            res = res.max(sum);
        }

        res
    }
}