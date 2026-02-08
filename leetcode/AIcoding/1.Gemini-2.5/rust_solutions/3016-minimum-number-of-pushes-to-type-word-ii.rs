impl Solution {
    pub fn minimum_pushes(word: String) -> i32 {
        let mut freq = [0; 26];

        for c in word.chars() {
            freq[(c as u8 - b'a') as usize] += 1;
        }

        let mut sorted_freqs: Vec<i32> = freq
            .iter()
            .filter(|&&f| f > 0)
            .map(|&f| f)
            .collect();

        sorted_freqs.sort_by(|a, b| b.cmp(a));

        let mut total_pushes = 0;
        let mut push_multiplier = 1;
        let mut chars_assigned_in_current_multiplier = 0;

        for f in sorted_freqs {
            total_pushes += f * push_multiplier;
            chars_assigned_in_current_multiplier += 1;

            if chars_assigned_in_current_multiplier == 9 {
                push_multiplier += 1;
                chars_assigned_in_current_multiplier = 0;
            }
        }

        total_pushes
    }
}