use std::collections::HashMap;

struct AuthenticationManager {
    time_to_live: i32,
    tokens: HashMap<String, i32>,
}

impl AuthenticationManager {
    fn new(time_to_live: i32) -> Self {
        Self {
            time_to_live,
            tokens: HashMap::new(),
        }
    }

    fn generate(&mut self, token_id: String, current_time: i32) {
        self.tokens.insert(token_id, current_time + self.time_to_live);
    }

    fn renew(&mut self, token_id: String, current_time: i32) {
        if let Some(&expire_time) = self.tokens.get(&token_id) {
            if current_time < expire_time {
                self.tokens.insert(token_id, current_time + self.time_to_live);
            }
        }
    }

    fn count_unexpired_tokens(&mut self, current_time: i32) -> i32 {
        self.tokens.retain(|_, &mut expire_time| current_time < expire_time);
        self.tokens.len() as i32
    }
}