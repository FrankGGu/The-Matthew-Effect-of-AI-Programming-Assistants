impl Solution {
    pub fn number_of_points(nums: Vec<Vec<i32>>) -> i32 {
        let mut intervals = nums;
        intervals.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut res = 0;
        let mut end = -1;

        for interval in intervals {
            let start = interval[0];
            let current_end = interval[1];

            if start > end {
                res += current_end - start + 1;
                end = current_end;
            } else if current_end > end {
                res += current_end - end;
                end = current_end;
            }
        }

        res
    }
}