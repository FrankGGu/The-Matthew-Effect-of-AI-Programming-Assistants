impl Solution {
    pub fn maximum_bags(capacity: Vec<i32>, rocks: Vec<i32>, additional_rocks: i32) -> i32 {
        let mut bags: Vec<i32> = capacity.iter().zip(rocks.iter()).map(|(c, r)| c - r).collect();
        bags.sort();
        let mut count = 0;
        let mut remaining_rocks = additional_rocks;

        for bag in bags {
            if remaining_rocks >= bag {
                remaining_rocks -= bag;
                count += 1;
            } else {
                break;
            }
        }

        count
    }
}