impl Solution {
    pub fn max_number_of_balloons(text: String) -> i32 {
        let mut counts = [0; 26];
        for c in text.chars() {
            counts[(c as u8 - b'a') as usize] += 1;
        }

        let b = counts[1]; // 'b'
        let a = counts[0]; // 'a'
        let l = counts[11] / 2; // 'l'
        let o = counts[14] / 2; // 'o'
        let n = counts[13]; // 'n'

        *[b, a, l, o, n].iter().min().unwrap()
    }
}