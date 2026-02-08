impl Solution {
    pub fn triangle_type(a: i32, b: i32, c: i32) -> String {
        if a <= 0 || b <= 0 || c <= 0 || a + b <= c || a + c <= b || b + c <= a {
            return "Invalid".to_string();
        }
        if a == b && b == c {
            return "Equilateral".to_string();
        }
        if a == b || b == c || a == c {
            return "Isosceles".to_string();
        }
        "Scalene".to_string()
    }
}