impl Solution {
    pub fn min_flips(target: String) -> i32 {
        let mut flips = 0;
        let mut current = '0';
        for c in target.chars() {
            if c != current {
                flips += 1;
                current = c;
            }
        }
        flips
    }
}