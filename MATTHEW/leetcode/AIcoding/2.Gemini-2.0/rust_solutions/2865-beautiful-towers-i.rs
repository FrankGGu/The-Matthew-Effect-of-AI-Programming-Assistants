impl Solution {
    pub fn maximum_sum_of_heights(maxHeights: Vec<i32>) -> i64 {
        let n = maxHeights.len();
        let mut ans = 0;
        for i in 0..n {
            let mut current_sum = 0;
            let mut current_height = maxHeights[i];
            current_sum += current_height as i64;
            for j in (0..i).rev() {
                current_height = std::cmp::min(current_height, maxHeights[j]);
                current_sum += current_height as i64;
            }
            current_height = maxHeights[i];
            for j in i + 1..n {
                current_height = std::cmp::min(current_height, maxHeights[j]);
                current_sum += current_height as i64;
            }
            ans = std::cmp::max(ans, current_sum);
        }
        ans
    }
}