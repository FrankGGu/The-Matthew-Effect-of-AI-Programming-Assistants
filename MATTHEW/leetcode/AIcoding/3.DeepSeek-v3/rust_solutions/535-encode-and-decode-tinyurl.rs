use std::collections::HashMap;
use rand::Rng;

struct Codec {
    url_to_code: HashMap<String, String>,
    code_to_url: HashMap<String, String>,
}

impl Codec {
    fn new() -> Self {
        Codec {
            url_to_code: HashMap::new(),
            code_to_url: HashMap::new(),
        }
    }

    fn encode(&mut self, long_url: String) -> String {
        if let Some(code) = self.url_to_code.get(&long_url) {
            return format!("http://tinyurl.com/{}", code);
        }

        let chars: Vec<char> = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".chars().collect();
        let mut rng = rand::thread_rng();
        let code: String = (0..6).map(|_| chars[rng.gen_range(0..chars.len())]).collect();

        self.url_to_code.insert(long_url.clone(), code.clone());
        self.code_to_url.insert(code.clone(), long_url);

        format!("http://tinyurl.com/{}", code)
    }

    fn decode(&self, short_url: String) -> String {
        let code = short_url.replace("http://tinyurl.com/", "");
        self.code_to_url.get(&code).unwrap().clone()
    }
}