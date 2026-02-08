use std::collections::HashMap;

struct Codec {
    url_map: HashMap<String, String>,
    base: String,
    count: usize,
}

impl Codec {
    fn new() -> Self {
        Codec {
            url_map: HashMap::new(),
            base: "http://tinyurl.com/".to_string(),
            count: 0,
        }
    }

    fn encode(&mut self, long_url: String) -> String {
        self.count += 1;
        let short_url = format!("{}{}", self.base, self.count);
        self.url_map.insert(short_url.clone(), long_url);
        short_url
    }

    fn decode(&self, short_url: String) -> String {
        self.url_map.get(&short_url).unwrap_or(&"".to_string()).clone()
    }
}