impl Solution {
    pub fn count_collisions(directions: String) -> i32 {
        let mut left = 0;
        let mut right = directions.len() - 1;
        let directions = directions.as_bytes();

        while left < directions.len() && directions[left] == b'L' {
            left += 1;
        }

        while right >= 0 && directions[right] == b'R' {
            right -= 1;
        }

        let mut collisions = 0;
        for i in left..=right {
            if directions[i] != b'S' {
                collisions += 1;
            }
        }

        collisions
    }
}