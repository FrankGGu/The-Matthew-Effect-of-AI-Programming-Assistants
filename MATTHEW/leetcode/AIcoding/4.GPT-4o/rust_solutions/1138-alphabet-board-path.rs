impl Solution {
    pub fn alphabet_board_path(target: String) -> String {
        let mut path = String::new();
        let mut x = 0;
        let mut y = 0;

        for c in target.chars() {
            let (tx, ty) = ((c as usize - 'a' as usize) / 5, (c as usize - 'a' as usize) % 5);
            if tx < x {
                path.push_str(&"U".repeat(x - tx));
            }
            if ty < y {
                path.push_str(&"L".repeat(y - ty));
            }
            if tx > x {
                path.push_str(&"D".repeat(tx - x));
            }
            if ty > y {
                path.push_str(&"R".repeat(ty - y));
            }
            path.push('!');
            x = tx;
            y = ty;
        }
        path
    }
}