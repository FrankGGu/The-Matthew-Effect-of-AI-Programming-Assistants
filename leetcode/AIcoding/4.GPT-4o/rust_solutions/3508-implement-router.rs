use std::collections::HashMap;

struct Router {
    routes: HashMap<String, String>,
}

impl Router {
    fn new() -> Self {
        Router {
            routes: HashMap::new(),
        }
    }

    fn add_route(&mut self, path: String, handler: String) {
        self.routes.insert(path, handler);
    }

    fn get_handler(&self, path: String) -> String {
        self.routes.get(&path).cloned().unwrap_or_else(|| "Not Found".to_string())
    }
}