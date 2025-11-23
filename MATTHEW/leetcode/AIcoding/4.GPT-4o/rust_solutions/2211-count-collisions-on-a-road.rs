impl Solution {
    pub fn count_collisions(directions: String) -> i32 {
        let mut collisions = 0;
        let mut last_char = ' ';

        for c in directions.chars() {
            if last_char == 'R' && c == 'L' {
                collisions += 2;
            } else if (last_char == 'R' && c == 'S') || (last_char == 'S' && c == 'L') {
                collisions += 1;
            } else if last_char == 'L' && c == 'S' {
                collisions += 1;
            }
            if c != 'S' {
                last_char = c;
            }
        }

        collisions
    }
}