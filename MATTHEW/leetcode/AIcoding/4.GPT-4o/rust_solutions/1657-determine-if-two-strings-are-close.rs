impl Solution {
    pub fn close_strings(word1: String, word2: String) -> bool {
        if word1.len() != word2.len() {
            return false;
        }

        let mut count1 = vec![0; 26];
        let mut count2 = vec![0; 26];
        let mut chars1 = vec![];
        let mut chars2 = vec![];

        for c in word1.chars() {
            count1[(c as usize - 'a' as usize)] += 1;
        }

        for c in word2.chars() {
            count2[(c as usize - 'a' as usize)] += 1;
        }

        for i in 0..26 {
            if count1[i] > 0 {
                chars1.push(count1[i]);
            }
            if count2[i] > 0 {
                chars2.push(count2[i]);
            }
        }

        chars1.sort();
        chars2.sort();

        chars1 == chars2
    }
}