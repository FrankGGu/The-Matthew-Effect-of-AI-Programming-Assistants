impl Solution {
    pub fn box_delivering(boxes: Vec<Vec<i32>>, ports_count: i32, max_boxes: i32, max_weight: i32) -> i32 {
        let n = boxes.len();
        let mut dp = vec![i64::MAX; n + 1];
        dp[0] = 0;
        for i in 1..=n {
            let mut weight = 0;
            let mut trips = 1;
            let mut boxes_count = 0;
            for j in (1..=i).rev() {
                weight += boxes[j - 1][1] as i64;
                boxes_count += 1;
                if j < i && boxes[j - 1][0] != boxes[j][0] {
                    trips += 1;
                }
                if boxes_count > max_boxes || weight > max_weight as i64 {
                    break;
                }
                if dp[j - 1] != i64::MAX {
                    dp[i] = dp[i].min(dp[j - 1] + trips + 1);
                }
            }
        }
        dp[n] as i32
    }
}