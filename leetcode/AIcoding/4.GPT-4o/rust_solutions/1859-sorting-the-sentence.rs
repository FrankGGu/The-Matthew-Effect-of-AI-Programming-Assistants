impl Solution {
    pub fn sort_sentence(s: String) -> String {
        let mut words: Vec<(&str, usize)> = s.split_whitespace()
            .map(|word| {
                let (w, n) = word.split_at(word.len() - 1);
                (w, n.parse::<usize>().unwrap())
            })
            .collect();

        words.sort_by_key(|&(_, n)| n);
        words.iter().map(|&(w, _)| w).collect::<Vec<&str>>().join(" ")
    }
}