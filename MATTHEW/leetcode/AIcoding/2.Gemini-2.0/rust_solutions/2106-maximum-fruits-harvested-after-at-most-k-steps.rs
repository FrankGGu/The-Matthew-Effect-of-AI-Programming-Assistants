impl Solution {
    pub fn max_total_fruits(fruits: Vec<Vec<i32>>, start_position: i32, k: i32) -> i32 {
        let n = fruits.len();
        let mut prefix_sum = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + fruits[i][1];
        }

        let mut ans = 0;
        for x in 0..n {
            for y in 0..n {
                let left = fruits[x][0].min(fruits[y][0]);
                let right = fruits[x][0].max(fruits[y][0]);
                let steps = (fruits[x][0] - start_position).abs() + (right - left).min((fruits[x][0] - fruits[y][0]).abs());
                if steps <= k {
                    let l = fruits[0][0];
                    let r = fruits[n - 1][0];

                    let mut start = 0;
                    let mut end = n - 1;
                    let mut left_index = -1;
                    while start <= end {
                        let mid = start + (end - start) / 2;
                        if fruits[mid][0] >= left {
                            left_index = mid as i32;
                            end = mid - 1;
                        } else {
                            start = mid + 1;
                        }
                    }

                    start = 0;
                    end = n - 1;
                    let mut right_index = -1;
                    while start <= end {
                        let mid = start + (end - start) / 2;
                        if fruits[mid][0] <= right {
                            right_index = mid as i32;
                            start = mid + 1;
                        } else {
                            end = mid - 1;
                        }
                    }

                    if left_index != -1 && right_index != -1 {
                        ans = ans.max(prefix_sum[right_index as usize + 1] - prefix_sum[left_index as usize]);
                    }
                }
            }
        }
        ans
    }
}