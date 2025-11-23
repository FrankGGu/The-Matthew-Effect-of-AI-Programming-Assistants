impl Solution {
    pub fn intersection_size_at_least_two(mut intervals: Vec<Vec<i32>>) -> i32 {
        intervals.sort_unstable_by(|a, b| {
            a[1].cmp(&b[1]).then_with(|| b[0].cmp(&a[0]))
        });

        let mut count = 0;
        let mut p1 = -1; // The smaller of the two largest points added to S
        let mut p2 = -1; // The larger of the two largest points added to S

        for interval in intervals {
            let a = interval[0];
            let b = interval[1];

            if a > p2 {
                // Neither p1 nor p2 are in the current interval [a, b].
                // We need to add two new points. The best choice is b-1 and b
                // to maximize their chances of intersecting future intervals.
                count += 2;
                p1 = b - 1;
                p2 = b;
            } else if a > p1 {
                // Only p2 is in the current interval [a, b], but p1 is not.
                // We need to add one more point. The best choice is b.
                // p1 effectively becomes p2, and p2 becomes b.
                count += 1;
                p1 = p2;
                p2 = b;
            }
            // If a <= p1, then both p1 and p2 are in [a, b]. No new points needed.
        }

        count
    }
}