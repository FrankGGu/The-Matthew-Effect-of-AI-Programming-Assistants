impl Solution {
    pub fn are_sentences_similar(sentence1: String, sentence2: String, similar_pairs: Vec<Vec<String>>) -> bool {
        let mut map = std::collections::HashSet::new();
        for pair in similar_pairs {
            map.insert((pair[0].clone(), pair[1].clone()));
            map.insert((pair[1].clone(), pair[0].clone()));
        }

        let words1: Vec<&str> = sentence1.split_whitespace().collect();
        let words2: Vec<&str> = sentence2.split_whitespace().collect();

        let len1 = words1.len();
        let len2 = words2.len();

        if len1 > len2 {
            return Self::check_similarity(&words1, &words2, &map);
        }

        let mut i = 0;
        while i < len1 && words1[i] == words2[i] {
            i += 1;
        }

        let mut j = len2 - 1;
        while j >= len2 - (len1 - i) && j < len2 {
            if words1[len1 - 1 - (len2 - 1 - j)] != words2[j] && !map.contains(&(words1[len1 - 1 - (len2 - 1 - j)].to_string(), words2[j].to_string())) {
                return false;
            }
            if j == 0 { break; }
            j -= 1;
        }

        i + (len2 - j - 1) == len1
    }

    fn check_similarity(words1: &[&str], words2: &[&str], map: &std::collections::HashSet<(String, String)>) -> bool {
        let mut i = 0;
        while i < words2.len() && i < words1.len() && words1[i] == words2[i] {
            i += 1;
        }

        let mut j = words2.len() - 1;
        while j >= words2.len() - (words1.len() - i) && j < words2.len() {
            if words1[words1.len() - 1 - (words2.len() - 1 - j)] != words2[j] && !map.contains(&(words1[words1.len() - 1 - (words2.len() - 1 - j)].to_string(), words2[j].to_string())) {
                return false;
            }
            if j == 0 { break; }
            j -= 1;
        }

        i + (words2.len() - j - 1) == words1.len()
    }
}