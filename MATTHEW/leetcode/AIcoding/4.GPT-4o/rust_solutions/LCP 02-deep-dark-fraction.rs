impl Solution {
    pub fn get_fraction(n: i32) -> String {
        let mut numerator = 1;
        let mut denominator = 1;
        let mut level = 1;

        while level * (level + 1) / 2 < n {
            level += 1;
        }
        let position = n - level * (level - 1) / 2;

        if level % 2 == 0 {
            numerator = position;
            denominator = level + 1 - position;
        } else {
            numerator = level + 1 - position;
            denominator = position;
        }

        format!("{}/{}", numerator, denominator)
    }
}