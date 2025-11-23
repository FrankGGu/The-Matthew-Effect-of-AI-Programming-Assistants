impl Solution {
    pub fn alphabet_board_path(target: String) -> String {
        let mut res = String::new();
        let mut current_pos = (0, 0);

        for c in target.chars() {
            let target_num = (c as u8 - b'a') as i32;
            let target_pos = (target_num / 5, target_num % 5);

            let mut dx = target_pos.0 - current_pos.0;
            let mut dy = target_pos.1 - current_pos.1;

            while dx < 0 {
                res.push('U');
                dx += 1;
            }
            while dy < 0 {
                res.push('L');
                dy += 1;
            }
            while dx > 0 {
                res.push('D');
                dx -= 1;
            }
            while dy > 0 {
                res.push('R');
                dy -= 1;
            }

            res.push('!');
            current_pos = target_pos;
        }

        res
    }
}