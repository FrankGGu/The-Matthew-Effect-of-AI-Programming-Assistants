impl Solution {
    pub fn odd_string(words: Vec<String>) -> String {
        let diffs: Vec<Vec<i32>> = words
            .iter()
            .map(|word| {
                let mut diff = Vec::new();
                for i in 0..word.len() - 1 {
                    diff.push((word.as_bytes()[i + 1] - word.as_bytes()[i]) as i32);
                }
                diff
            })
            .collect();

        let first = &diffs[0];
        let second = &diffs[1];
        let third = &diffs[2];

        if first == second {
            for i in 3..diffs.len() {
                if &diffs[i] != first {
                    return words[i].clone();
                }
            }
            return words[0].clone();
        } else if first == third {
            return words[1].clone();
        } else {
            return words[0].clone();
        }
    }
}