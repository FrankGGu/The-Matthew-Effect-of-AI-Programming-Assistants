use std::collections::HashMap;

struct Codec {
    long_to_short: HashMap<String, String>,
    short_to_long: HashMap<String, String>,
    counter: usize,
    base_url: String,
}

impl Codec {
    fn new() -> Self {
        Codec {
            long_to_short: HashMap::new(),
            short_to_long: HashMap::new(),
            counter: 0,
            base_url: "http://tinyurl.com/".to_string(),
        }
    }

    fn encode(&mut self, long_url: String) -> String {
        if let Some(short_url) = self.long_to_short.get(&long_url) {
            return short_url.clone();
        }

        self.counter += 1;
        let short_code = self.counter.to_string();
        let short_url = format!("{}{}", self.base_url, short_code);

        self.long_to_short.insert(long_url.clone(), short_url.clone());
        self.short_to_long.insert(short_url.clone(), long_url);

        short_url
    }

    fn decode(&mut self, short_url: String) -> String {
        self.short_to_long.get(&short_url).unwrap().clone()
    }
}