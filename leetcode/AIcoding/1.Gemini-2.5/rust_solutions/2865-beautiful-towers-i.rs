impl Solution {
    pub fn maximum_beauty_of_towers(max_heights: Vec<i32>) -> i64 {
        let n = max_heights.len();
        let mut left_sums: Vec<i64> = vec![0; n];
        let mut right_sums: Vec<i64> = vec![0; n];

        let mut stack: Vec<(i64, i64)> = Vec::new(); // (height, count)
        let mut current_sum: i64 = 0;

        // Calculate left_sums: max sum of a non-decreasing sequence ending at i
        for i in 0..n {
            let h = max_heights[i] as i64;
            let mut count: i64 = 1;

            while let Some(&(prev_h, prev_count)) = stack.last() {
                if prev_h > h {
                    current_sum -= prev_h * prev_count;
                    count += prev_count;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push((h, count));
            current_sum += h * count;
            left_sums[i] = current_sum;
        }

        // Calculate right_sums: max sum of a non-increasing sequence starting at i
        stack.clear();
        current_sum = 0;

        for i in (0..n).rev() {
            let h = max_heights[i] as i64;
            let mut count: i64 = 1;

            while let Some(&(prev_h, prev_count)) = stack.last() {
                if prev_h > h {
                    current_sum -= prev_h * prev_count;
                    count += prev_count;
                    stack.pop();
                } else {
                    break;
                }
            }
            stack.push((h, count));
            current_sum += h * count;
            right_sums[i] = current_sum;
        }

        // Calculate final maximum beauty by considering each index as a peak
        let mut max_beauty: i64 = 0;
        for i in 0..n {
            let total_sum = left_sums[i] + right_sums[i] - (max_heights[i] as i64);
            if total_sum > max_beauty {
                max_beauty = total_sum;
            }
        }

        max_beauty
    }
}