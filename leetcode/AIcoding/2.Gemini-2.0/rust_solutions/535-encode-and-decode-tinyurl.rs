use std::collections::HashMap;
use rand::Rng;

struct Codec {
    url_map: HashMap<String, String>,
    code_map: HashMap<String, String>,
    base: String,
}

impl Codec {
    fn new() -> Self {
        Codec {
            url_map: HashMap::new(),
            code_map: HashMap::new(),
            base: "http://tinyurl.com/".to_string(),
        }
    }

    // Encodes a URL to a shortened URL.
    fn encode(&mut self, longURL: String) -> String {
        if self.url_map.contains_key(&longURL) {
            return self.url_map.get(&longURL).unwrap().clone();
        }

        let mut rng = rand::thread_rng();
        let mut code = String::new();
        for _ in 0..6 {
            let i: u8 = rng.gen_range(0..62);
            code.push(match i {
                0..=9 => (i + b'0') as char,
                10..=35 => (i - 10 + b'a') as char,
                _ => (i - 36 + b'A') as char,
            });
        }

        while self.code_map.contains_key(&code) {
            code.clear();
            for _ in 0..6 {
                let i: u8 = rng.gen_range(0..62);
                code.push(match i {
                    0..=9 => (i + b'0') as char,
                    10..=35 => (i - 10 + b'a') as char,
                    _ => (i - 36 + b'A') as char,
                });
            }
        }

        let tiny_url = self.base.clone() + &code;
        self.url_map.insert(longURL.clone(), tiny_url.clone());
        self.code_map.insert(code, longURL);

        tiny_url
    }

    // Decodes a shortened URL to its original URL.
    fn decode(&self, tinyURL: String) -> String {
        let code = tinyURL.replace(&self.base, "");
        self.code_map.get(&code).unwrap().clone()
    }
}