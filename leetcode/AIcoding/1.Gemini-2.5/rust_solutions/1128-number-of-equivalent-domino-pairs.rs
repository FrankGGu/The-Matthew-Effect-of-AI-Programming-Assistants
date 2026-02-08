impl Solution {
    pub fn num_equivalent_domino_pairs(dominoes: Vec<Vec<i32>>) -> i32 {
        let mut counts = vec![0; 100];

        for domino in dominoes {
            let d0 = domino[0];
            let d1 = domino[1];

            let min_val = d0.min(d1);
            let max_val = d0.max(d1);

            let index = (min_val * 10 + max_val) as usize;
            counts[index] += 1;
        }

        let mut total_pairs = 0;
        for count in counts {
            if count >= 2 {
                total_pairs += count * (count - 1) / 2;
            }
        }

        total_pairs
    }
}