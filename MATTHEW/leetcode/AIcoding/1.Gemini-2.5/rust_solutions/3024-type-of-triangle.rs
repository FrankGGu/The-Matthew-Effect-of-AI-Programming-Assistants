impl Solution {
    pub fn triangle_type(x: i32, y: i32, z: i32) -> String {
        if x <= 0 || y <= 0 || z <= 0 || x + y <= z || x + z <= y || y + z <= x {
            "None".to_string()
        } else if x == y && y == z {
            "Equilateral".to_string()
        } else if x == y || y == z || x == z {
            "Isosceles".to_string()
        } else {
            "Scalene".to_string()
        }
    }
}