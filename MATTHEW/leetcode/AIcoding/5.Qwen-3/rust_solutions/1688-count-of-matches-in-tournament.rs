struct Solution;

impl Solution {
    pub fn number_of_matches(n: i32) -> i32 {
        let mut matches = 0;
        let mut teams = n;
        while teams > 1 {
            if teams % 2 == 0 {
                matches += teams / 2;
                teams /= 2;
            } else {
                matches += (teams - 1) / 2;
                teams = (teams - 1) / 2 + 1;
            }
        }
        matches
    }
}