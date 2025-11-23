impl Solution {
    pub fn replace_words(dictionary: Vec<String>, sentence: String) -> String {
        let mut trie = std::collections::HashMap::new();
        for root in dictionary {
            let mut node = &mut trie;
            for ch in root.chars() {
                node = node.entry(ch).or_insert(std::collections::HashMap::new());
            }
            node.insert('$', true);
        }

        sentence.split_whitespace()
            .map(|word| {
                let mut node = &trie;
                let mut prefix = String::new();
                for ch in word.chars() {
                    if node.contains_key(&ch) {
                        prefix.push(ch);
                        node = node.get(&ch).unwrap();
                        if node.contains_key(&'$') {
                            return prefix;
                        }
                    } else {
                        break;
                    }
                }
                word.to_string()
            })
            .collect::<Vec<_>>()
            .join(" ")
    }
}