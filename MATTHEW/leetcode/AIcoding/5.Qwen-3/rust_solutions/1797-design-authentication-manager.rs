impl Solution {

use std::collections::HashMap;

struct AuthenticationManager {
    time_to_live: i32,
    tokens: HashMap<String, i32>,
}

impl AuthenticationManager {
    fn new(time_to_live: i32) -> Self {
        AuthenticationManager {
            time_to_live,
            tokens: HashMap::new(),
        }
    }

    fn generate(&mut self, token_id: String, expires_in: i32) {
        self.tokens.insert(token_id, expires_in);
    }

    fn renew(&mut self, token_id: String, expires_in: i32) {
        if let Some(expire_time) = self.tokens.get_mut(&token_id) {
            *expire_time = expires_in;
        }
    }

    fn count_unexpired_tokens(&self, current_time: i32) -> i32 {
        self.tokens
            .values()
            .filter(|&&expire_time| expire_time > current_time)
            .count() as i32
    }
}
}