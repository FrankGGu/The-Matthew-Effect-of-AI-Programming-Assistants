impl Solution {
    pub fn rune_reserve(runes: Vec<i32>) -> i32 {
        let mut runes = runes;
        runes.sort();
        let mut count = 1;
        let mut current = runes[0];
        for i in 1..runes.len() {
            if runes[i] == current + 1 {
                count += 1;
                current = runes[i];
            } else {
                count = 1;
                current = runes[i];
            }
        }
        count as i32
    }
}