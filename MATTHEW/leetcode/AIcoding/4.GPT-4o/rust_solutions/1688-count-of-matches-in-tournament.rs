impl Solution {
    pub fn number_of_matches(n: i32) -> i32 {
        let mut matches = 0;
        let mut teams = n;

        while teams > 1 {
            let current_matches = teams / 2;
            matches += current_matches;
            teams = (teams + 1) / 2;
        }

        matches
    }
}