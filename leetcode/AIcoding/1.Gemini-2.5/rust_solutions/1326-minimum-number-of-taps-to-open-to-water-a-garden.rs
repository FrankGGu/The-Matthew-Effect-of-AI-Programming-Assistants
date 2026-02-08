impl Solution {
    pub fn min_taps(n: i32, ranges: Vec<i32>) -> i32 {
        let n_usize = n as usize;
        // max_reach[j] stores the maximum point that can be watered
        // by a tap whose watering range starts at `j`.
        let mut max_reach: Vec<i32> = vec![0; n_usize + 1];

        // Preprocessing: Populate max_reach array
        for i in 0..=n_usize {
            let r = ranges[i];
            // Calculate the actual start and end points of the tap's coverage
            let start = (i as i32 - r).max(0);
            let end = (i as i32 + r).min(n);

            // Update max_reach for the calculated start point
            // A tap starting at `start` can reach `end`. We want to store the furthest `end`.
            max_reach[start as usize] = max_reach[start as usize].max(end);
        }

        let mut taps = 0;
        let mut current_reach = 0; // The furthest point watered so far using `taps` taps
        let mut max_possible_reach = 0; // The furthest point we can reach by opening one more tap from current position

        // Iterate through the garden points from 0 to n
        for i in 0..=n_usize {
            // Update max_possible_reach by considering taps that start at `i`
            max_possible_reach = max_possible_reach.max(max_reach[i]);

            // If the current point `i` is beyond what we have watered so far (`current_reach`),
            // it means there's a gap that cannot be covered.
            if i as i32 > current_reach {
                return -1;
            }

            // If we have reached the end of the current tap's coverage (`current_reach`),
            // we must open a new tap to extend coverage.
            if i as i32 == current_reach {
                taps += 1;
                current_reach = max_possible_reach; // Update `current_reach` with the best possible tap found so far

                // If the entire garden `[0, n]` is watered
                if current_reach >= n {
                    return taps;
                }
                // If we couldn't extend coverage further (stuck at `i`), it's impossible.
                // This means `max_possible_reach` was not greater than `i`.
                if current_reach <= i as i32 {
                    return -1;
                }
            }
        }

        // This line should theoretically be unreachable because the loop's conditions
        // (returning `taps` or `-1`) cover all scenarios.
        // If the loop finishes without returning, it implies `n` was not covered,
        // which should have been caught by `i as i32 > current_reach` or `current_reach <= i as i32`.
        unreachable!()
    }
}