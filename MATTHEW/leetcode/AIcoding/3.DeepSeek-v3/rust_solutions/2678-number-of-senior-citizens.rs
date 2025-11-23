impl Solution {
    pub fn count_seniors(details: Vec<String>) -> i32 {
        details.iter().filter(|s| {
            let age_str = &s[11..13];
            let age: i32 = age_str.parse().unwrap();
            age > 60
        }).count() as i32
    }
}