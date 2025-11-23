impl Solution {
    pub fn count_collisions(road: String) -> i32 {
        let chars: Vec<char> = road.chars().collect();
        let n = chars.len();

        if n <= 1 {
            return 0;
        }

        let mut left = 0;
        while left < n && chars[left] == 'L' {
            left += 1;
        }

        let mut right = n - 1;
        while right >= left && chars[right] == 'R' {
            right -= 1;
        }

        let mut collisions = 0;
        for i in left..=right {
            if chars[i] != 'S' {
                collisions += 1;
            }
        }

        collisions
    }
}