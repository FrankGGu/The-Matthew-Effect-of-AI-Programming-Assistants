impl Solution {
    pub fn generate_dynamic_password(n: i32) -> String {
        let mut password = String::new();
        for i in 0..n {
            password.push_str(&format!("{:02}", i));
        }
        password
    }
}