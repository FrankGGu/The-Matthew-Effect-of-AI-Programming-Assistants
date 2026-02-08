impl Solution {
    pub fn alphabet_board_path(target: String) -> String {
        let mut result = String::new();
        let mut current = (0, 0);

        for c in target.chars() {
            let target_pos = (
                (c as u8 - b'a') as i32 / 5,
                (c as u8 - b'a') as i32 % 5,
            );

            let mut path = String::new();

            while current.1 < target_pos.1 {
                path.push('R');
                current.1 += 1;
            }

            while current.1 > target_pos.1 {
                path.push('L');
                current.1 -= 1;
            }

            while current.0 < target_pos.0 {
                path.push('D');
                current.0 += 1;
            }

            while current.0 > target_pos.0 {
                path.push('U');
                current.0 -= 1;
            }

            result.push_str(&path);
            result.push('!');
        }

        result
    }
}