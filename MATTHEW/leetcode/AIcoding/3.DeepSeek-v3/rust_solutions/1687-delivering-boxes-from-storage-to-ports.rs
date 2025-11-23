impl Solution {
    pub fn box_delivering(boxes: Vec<Vec<i32>>, ports_count: i32, max_boxes: i32, max_weight: i32) -> i32 {
        let n = boxes.len();
        let mut dp = vec![0; n + 1];
        let mut left = 0;
        let mut current_weight = 0;
        let mut current_trips = 0;

        for right in 0..n {
            if right == 0 || boxes[right][0] != boxes[right - 1][0] {
                current_trips += 1;
            }
            current_weight += boxes[right][1];

            while right - left + 1 > max_boxes as usize || 
                  current_weight > max_weight || 
                  (left < right && dp[left] == dp[left + 1]) {
                current_weight -= boxes[left][1];
                if boxes[left][0] != boxes[left + 1][0] {
                    current_trips -= 1;
                }
                left += 1;
            }

            dp[right + 1] = dp[left] + current_trips + 1;
        }

        dp[n]
    }
}