impl Solution {
    pub fn maximum_bags(capacity: Vec<i32>, rocks: Vec<i32>, additional_rocks: i32) -> i32 {
        let mut diffs: Vec<i32> = capacity.iter().zip(rocks.iter()).map(|(&c, &r)| c - r).collect();
        diffs.sort_unstable();
        let mut additional = additional_rocks;
        let mut count = 0;
        for diff in diffs {
            if additional >= diff {
                additional -= diff;
                count += 1;
            } else {
                break;
            }
        }
        count
    }
}