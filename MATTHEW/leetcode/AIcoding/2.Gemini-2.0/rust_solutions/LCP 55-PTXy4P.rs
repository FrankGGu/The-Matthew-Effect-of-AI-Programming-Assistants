impl Solution {
    pub fn max_total_fruits(fruits: Vec<Vec<i32>>, start_position: i32, k: i32) -> i32 {
        let mut ans = 0;
        let mut left = 0;
        let mut cur = 0;
        for right in 0..fruits.len() {
            cur += fruits[right][1];
            while left <= right {
                let dist = (fruits[right][0] - start_position).abs().min((fruits[left][0] - start_position).abs());
                let total_dist = (fruits[right][0] - fruits[left][0]).abs() + dist;
                if total_dist <= k {
                    ans = ans.max(cur);
                    break;
                } else {
                    cur -= fruits[left][1];
                    left += 1;
                }
            }
        }
        ans
    }
}