impl Solution {
    pub fn intersection_size_two(intervals: Vec<Vec<i32>>) -> i32 {
        let mut intervals = intervals;
        intervals.sort_by(|a, b| {
            if a[1] == b[1] {
                b[0].cmp(&a[0])
            } else {
                a[1].cmp(&b[1])
            }
        });

        let mut result = 0;
        let mut first = -1;
        let mut second = -1;

        for interval in intervals {
            let start = interval[0];
            let end = interval[1];

            if start > second {
                result += 2;
                first = end - 1;
                second = end;
            } else if start > first {
                result += 1;
                first = second;
                second = end;
            }
        }

        result
    }
}