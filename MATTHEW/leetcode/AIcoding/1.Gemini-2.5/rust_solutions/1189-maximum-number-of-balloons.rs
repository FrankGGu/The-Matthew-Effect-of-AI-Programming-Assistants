impl Solution {
    pub fn max_number_of_balloons(text: String) -> i32 {
        let mut char_counts = [0; 26]; // Frequencies for 'a' through 'z'

        for c in text.chars() {
            if c >= 'a' && c <= 'z' {
                char_counts[(c as usize - 'a' as usize)] += 1;
            }
        }

        let b_available = char_counts[('b' as usize - 'a' as usize)];
        let a_available = char_counts[('a' as usize - 'a' as usize)];
        let l_available = char_counts[('l' as usize - 'a' as usize)];
        let o_available = char_counts[('o' as usize - 'a' as usize)];
        let n_available = char_counts[('n' as usize - 'a' as usize)];

        let mut max_balloons = i32::MAX;

        max_balloons = max_balloons.min(b_available);
        max_balloons = max_balloons.min(a_available);
        max_balloons = max_balloons.min(n_available);
        max_balloons = max_balloons.min(l_available / 2);
        max_balloons = max_balloons.min(o_available / 2);

        max_balloons
    }
}