#[derive(Debug, PartialEq, Eq, Clone)]
pub struct User {
    pub id: i32,
    pub name: String,
    pub score: i32,
}

impl Solution {
    pub fn select_data(users: Vec<User>) -> Vec<User> {
        users.into_iter()
            .filter(|user| user.score > 100)
            .collect()
    }
}