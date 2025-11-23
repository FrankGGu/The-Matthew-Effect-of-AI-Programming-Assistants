struct Codec {
    map: std::collections::HashMap<String, String>,
    counter: i32,
}

impl Codec {
    fn new() -> Self {
        Codec {
            map: std::collections::HashMap::new(),
            counter: 0,
        }
    }

    fn encode(&mut self, long_url: String) -> String {
        self.counter += 1;
        let short = format!("http://tinyurl.com/{}", self.counter);
        self.map.insert(short.clone(), long_url);
        short
    }

    fn decode(&self, short_url: String) -> String {
        self.map.get(&short_url).cloned().unwrap_or_default()
    }
}