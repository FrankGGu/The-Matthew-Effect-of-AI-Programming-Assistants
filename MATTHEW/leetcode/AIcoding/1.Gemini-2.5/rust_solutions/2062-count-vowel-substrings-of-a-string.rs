impl Solution {
    pub fn count_vowel_substrings(word: String) -> i64 {
        let chars: Vec<char> = word.chars().collect();
        let n = chars.len();
        let mut total_count: i64 = 0;
        let mut start_idx: usize = 0;

        for i in 0..=n {
            if i == n || !Self::is_vowel(chars[i]) {
                if start_idx < i {
                    total_count += Self::count_valid_in_segment(&chars[start_idx..i]);
                }
                start_idx = i + 1;
            }
        }
        total_count
    }

    fn is_vowel(c: char) -> bool {
        c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u'
    }

    fn vowel_to_idx(c: char) -> usize {
        match c {
            'a' => 0,
            'e' => 1,
            'i' => 2,
            'o' => 3,
            'u' => 4,
            _ => 0, // Should not be reached if called after is_vowel check
        }
    }

    fn count_valid_in_segment(segment: &[char]) -> i64 {
        let mut count: i64 = 0;
        let mut left: usize = 0;
        let mut freq: [i32; 5] = [0; 5];
        let mut distinct_vowels: i32 = 0;

        for right in 0..segment.len() {
            let char_idx = Self::vowel_to_idx(segment[right]);

            freq[char_idx] += 1;
            if freq[char_idx] == 1 {
                distinct_vowels += 1;
            }

            while distinct_vowels == 5 {
                count += (left + 1) as i64;

                let left_char_idx = Self::vowel_to_idx(segment[left]);
                freq[left_char_idx] -= 1;
                if freq[left_char_idx] == 0 {
                    distinct_vowels -= 1;
                }
                left += 1;
            }
        }
        count
    }
}