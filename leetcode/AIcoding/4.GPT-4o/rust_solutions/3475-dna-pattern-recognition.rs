pub fn find_dna_sequences(s: String) -> Vec<String> {
    use std::collections::HashSet;
    let mut seen = HashSet::new();
    let mut result = HashSet::new();

    for i in 0..s.len() - 9 {
        let seq = &s[i..i + 10];
        if seen.contains(seq) {
            result.insert(seq.to_string());
        } else {
            seen.insert(seq);
        }
    }

    result.into_iter().collect()
}