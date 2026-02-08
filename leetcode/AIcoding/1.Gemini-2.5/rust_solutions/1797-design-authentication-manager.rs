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
        if let Some(expiration_time) = self.tokens.get_mut(&token_id) {
            if *expiration_time > current_time {
                *expiration_time = current_time + self.time_to_live;
            }
        }
    }

    fn count_unexpired_tokens(&self, current_time: i32) -> i32 {
        let mut count = 0;
        for &expiration_time in self.tokens.values() {
            if expiration_time > current_time {
                count += 1;
            }
        }
        count
    }
}