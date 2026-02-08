impl Solution {
    pub fn deck_reveal(cards: Vec<i32>) -> Vec<i32> {
        let n = cards.len();
        let mut indices: Vec<usize> = (0..n).collect();
        indices.sort_unstable_by_key(|&i| cards[i]);
        let mut result = vec![0; n];
        let mut pos = 0;
        for i in indices {
            result[pos] = cards[i];
            pos = (pos + 1) % n;
            if pos > 0 {
                pos = (pos + 1) % n;
            }
        }
        result
    }
}