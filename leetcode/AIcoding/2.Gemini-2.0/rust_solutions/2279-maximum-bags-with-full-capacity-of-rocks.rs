impl Solution {
    pub fn maximum_bags(capacity: Vec<i32>, rocks: Vec<i32>, additional_rocks: i32) -> i32 {
        let mut diff: Vec<i32> = capacity.iter().zip(rocks.iter()).map(|(&c, &r)| c - r).collect();
        diff.sort();
        let mut count = 0;
        let mut remaining_rocks = additional_rocks;
        for &d in &diff {
            if d == 0 {
                count += 1;
            } else if remaining_rocks >= d {
                remaining_rocks -= d;
                count += 1;
            } else {
                break;
            }
        }
        count
    }
}