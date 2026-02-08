impl Solution {
    pub fn spellchecker(wordlist: Vec<String>, queries: Vec<String>) -> Vec<String> {
        let mut exact_set = std::collections::HashSet::new();
        let mut vowel_variants = std::collections::HashMap::new();
        let vowels = "aeiou";

        for word in &wordlist {
            exact_set.insert(word.clone());
            let vowel_word = word.chars().map(|c| {
                if vowels.contains(c) { '*' } else { c }
            }).collect::<String>();
            vowel_variants.entry(vowel_word).or_insert(word.clone());
        }

        queries.into_iter().map(|query| {
            if exact_set.contains(&query) {
                return query;
            }
            let vowel_query = query.chars().map(|c| {
                if vowels.contains(c) { '*' } else { c }
            }).collect::<String>();
            vowel_variants.get(&vowel_query).cloned().unwrap_or_default()
        }).collect()
    }
}