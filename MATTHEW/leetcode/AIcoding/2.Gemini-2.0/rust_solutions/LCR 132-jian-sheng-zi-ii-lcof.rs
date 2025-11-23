impl Solution {
    pub fn minimum_rounds(piles: Vec<i32>) -> i32 {
        let mut count = std::collections::HashMap::new();
        for &pile in &piles {
            *count.entry(pile).or_insert(0) += 1;
        }

        let mut rounds = 0;
        for &cnt in count.values() {
            if cnt == 1 {
                return -1;
            }
            rounds += (cnt + 2) / 3;
        }

        rounds
    }
}