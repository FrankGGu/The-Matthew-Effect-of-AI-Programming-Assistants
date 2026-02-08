impl Solution {
    pub fn maximum_bags(capacity: Vec<i32>, rocks: Vec<i32>, mut additional_rocks: i32) -> i32 {
        let n = capacity.len();
        let mut diffs: Vec<i32> = Vec::with_capacity(n);

        for i in 0..n {
            diffs.push(capacity[i] - rocks[i]);
        }

        diffs.sort_unstable();

        let mut full_bags_count = 0;
        for diff in diffs {
            if diff == 0 {
                full_bags_count += 1;
            } else if additional_rocks >= diff {
                additional_rocks -= diff;
                full_bags_count += 1;
            } else {
                break;
            }
        }

        full_bags_count
    }
}