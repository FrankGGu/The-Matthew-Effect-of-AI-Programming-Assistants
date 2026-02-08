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

    fn generate(&mut self, token_id: String, current_time: i32) {
        self.tokens.insert(token_id, current_time + self.time_to_live);
    }

    fn renew(&mut self, token_id: String, current_time: i32) {
        if let Some(expiry) = self.tokens.get_mut(&token_id) {
            if *expiry > current_time {
                *expiry = current_time + self.time_to_live;
            }
        }
    }

    fn count_unexpired_tokens(&self, current_time: i32) -> i32 {
        self.tokens.values().filter(|&&expiry| expiry > current_time).count() as i32
    }
}