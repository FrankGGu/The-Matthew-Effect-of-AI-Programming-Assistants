impl Solution {
    pub fn is_alien_sorted(words: Vec<String>, order: String) -> bool {
        let mut index = vec![0; 26];
        for (i, c) in order.chars().enumerate() {
            index[(c as usize - 'a' as usize)] = i;
        }

        let mut prev_word = "";
        for word in words.iter() {
            let mut curr_word = word.chars().map(|c| index[(c as usize - 'a' as usize)]).collect::<Vec<_>>();
            let mut prev_curr = prev_word.chars().map(|c| index[(c as usize - 'a' as usize)]).collect::<Vec<_>>();

            if curr_word < prev_curr {
                return false;
            }
            prev_word = word;
        }

        true
    }
}