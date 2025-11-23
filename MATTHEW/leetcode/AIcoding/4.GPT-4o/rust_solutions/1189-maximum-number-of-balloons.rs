impl Solution {
    pub fn max_number_of_balloons(text: String) -> i32 {
        let mut counts = [0; 26];
        for c in text.chars() {
            counts[(c as usize) - ('a' as usize)] += 1;
        }
        let b = counts[1];
        let a = counts[0];
        let l = counts[11] / 2;
        let o = counts[14] / 2;
        let n = counts[13];
        *[b, a, l, o, n].iter().min().unwrap()
    }
}