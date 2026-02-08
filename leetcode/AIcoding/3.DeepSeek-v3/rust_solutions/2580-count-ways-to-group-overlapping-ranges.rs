impl Solution {
    pub fn count_ways(ranges: Vec<Vec<i32>>) -> i32 {
        let mut ranges = ranges;
        ranges.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut groups = 1;
        let mut end = ranges[0][1];

        for i in 1..ranges.len() {
            if ranges[i][0] > end {
                groups += 1;
                end = ranges[i][1];
            } else {
                end = end.max(ranges[i][1]);
            }
        }

        let mut res = 1;
        for _ in 0..groups {
            res = (res * 2) % 1_000_000_007;
        }

        res
    }
}