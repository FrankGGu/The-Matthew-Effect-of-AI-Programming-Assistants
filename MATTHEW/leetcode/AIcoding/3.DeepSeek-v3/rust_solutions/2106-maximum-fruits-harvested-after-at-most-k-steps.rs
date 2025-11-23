impl Solution {
    pub fn max_total_fruits(fruits: Vec<Vec<i32>>, start_pos: i32, k: i32) -> i32 {
        let mut left = 0;
        let mut right = 0;
        let n = fruits.len();
        let mut sum = 0;
        let mut max_sum = 0;

        while right < n {
            sum += fruits[right][1];
            while left <= right && !Self::is_reachable(&fruits, left, right, start_pos, k) {
                sum -= fruits[left][1];
                left += 1;
            }
            max_sum = max_sum.max(sum);
            right += 1;
        }
        max_sum
    }

    fn is_reachable(fruits: &[Vec<i32>], left: usize, right: usize, start_pos: i32, k: i32) -> bool {
        let left_pos = fruits[left][0];
        let right_pos = fruits[right][0];
        if right_pos <= start_pos {
            start_pos - left_pos <= k
        } else if left_pos >= start_pos {
            right_pos - start_pos <= k
        } else {
            let left_dist = start_pos - left_pos;
            let right_dist = right_pos - start_pos;
            (left_dist <= right_dist && 2 * left_dist + right_dist <= k)
                || (right_dist <= left_dist && 2 * right_dist + left_dist <= k)
        }
    }
}