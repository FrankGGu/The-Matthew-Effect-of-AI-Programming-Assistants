impl Solution {
    pub fn crack_password(password: Vec<i32>) -> String {
        let mut nums: Vec<String> = password.iter().map(|&x| x.to_string()).collect();
        nums.sort_by(|a, b| (a.clone() + b).cmp(&(b.clone() + a)));
        nums.join("")
    }
}