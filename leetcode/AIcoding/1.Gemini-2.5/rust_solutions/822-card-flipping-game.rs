use std::collections::HashSet;

impl Solution {
    pub fn flipgame(fronts: Vec<i32>, backs: Vec<i32>) -> i32 {
        let mut bad_numbers: HashSet<i32> = HashSet::new();

        for i in 0..fronts.len() {
            if fronts[i] == backs[i] {
                bad_numbers.insert(fronts[i]);
            }
        }

        // A number 'x' is "good" if it is not present on both sides of any single card.
        // We are looking for the smallest such 'x'.
        // The problem constraints state that card values are between 1 and 1000.
        // The phrase "If there are no such numbers, return 0." suggests that 'x'
        // is expected to be within this range (1 to 1000).
        // If all numbers from 1 to 1000 are "bad", then 0 should be returned.
        for k in 1..=1000 {
            if !bad_numbers.contains(&k) {
                return k;
            }
        }

        // If the loop completes, it means all integers from 1 to 1000 are in `bad_numbers`.
        // According to the problem statement ("If there are no such numbers, return 0."),
        // we should return 0 in this scenario.
        0
    }
}