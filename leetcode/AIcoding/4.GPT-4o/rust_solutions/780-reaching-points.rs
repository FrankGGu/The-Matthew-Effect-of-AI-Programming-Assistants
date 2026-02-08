impl Solution {
    pub fn can_reach(x: i32, y: i32, target_x: i32, target_y: i32) -> bool {
        let (mut x, mut y, mut target_x, mut target_y) = (x as i64, y as i64, target_x as i64, target_y as i64);
        while target_x >= x && target_y >= y {
            if target_x == x && target_y == y {
                return true;
            }
            if target_x > target_y {
                target_x -= target_y - target_y / target_x * target_x;
            } else {
                target_y -= target_x - target_x / target_y * target_y;
            }
        }
        (x == target_x && target_y >= y && (target_y - y) % x == 0) || 
        (y == target_y && target_x >= x && (target_x - x) % y == 0)
    }
}