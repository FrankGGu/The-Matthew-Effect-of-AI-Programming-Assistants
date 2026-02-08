impl Solution {
    pub fn deck_revealed_increasing(deck: Vec<i32>) -> Vec<i32> {
        let mut deck = deck;
        deck.sort();
        let mut result: Vec<i32> = Vec::new();
        let mut index: Vec<usize> = (0..deck.len()).collect();

        for &card in deck.iter() {
            result.push(card);
            if index.len() > 1 {
                index.push(index[1]);
                index.remove(0);
                index.remove(0);
            } else {
                index.remove(0);
            }
        }

        let mut final_result = vec![0; result.len()];
        for i in 0..result.len() {
            final_result[index[i]] = result[i];
        }

        final_result
    }
}