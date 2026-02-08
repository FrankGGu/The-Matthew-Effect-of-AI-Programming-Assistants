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

        let mut res = 0;
        let mut p1 = -1;
        let mut p2 = -1;

        for interval in intervals {
            let start = interval[0];
            let end = interval[1];

            if p1 >= start && p2 >= start {
                continue;
            } else if p1 >= start {
                res += 1;
                p2 = end;
                p1 = end - 1;
            } else {
                res += 2;
                p2 = end;
                p1 = end - 1;
            }
        }

        res
    }
}