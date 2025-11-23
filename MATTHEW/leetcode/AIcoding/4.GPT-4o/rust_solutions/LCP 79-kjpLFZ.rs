impl Solution {
    pub fn min_spell_length(spell: String, words: Vec<String>) -> i32 {
        let spell_chars: Vec<_> = spell.chars().collect();
        let mut min_length = i32::MAX;

        for word in words {
            let word_chars: Vec<_> = word.chars().collect();
            let mut spell_index = 0;
            for &c in &word_chars {
                if spell_index < spell_chars.len() && c == spell_chars[spell_index] {
                    spell_index += 1;
                }
                if spell_index == spell_chars.len() {
                    min_length = min_length.min(word.len() as i32);
                    break;
                }
            }
        }

        if min_length == i32::MAX { -1 } else { min_length }
    }
}