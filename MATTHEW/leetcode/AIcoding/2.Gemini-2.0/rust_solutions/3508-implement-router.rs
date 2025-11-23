use std::collections::HashMap;

struct Router {
    routes: HashMap<String, Box<dyn Fn(HashMap<String, String>) -> String>>,
}

impl Router {
    fn new() -> Self {
        Router {
            routes: HashMap::new(),
        }
    }

    fn add_route<F>(&mut self, path: String, handler: F)
    where
        F: Fn(HashMap<String, String>) -> String + 'static,
    {
        self.routes.insert(path, Box::new(handler));
    }

    fn route(&self, path: String) -> Option<String> {
        let mut best_match: Option<(&String, &Box<dyn Fn(HashMap<String, String>) -> String>)> = None;
        let mut best_match_params: HashMap<String, String> = HashMap::new();

        for (route_path, handler) in &self.routes {
            let mut params: HashMap<String, String> = HashMap::new();
            if self.match_path(&path, route_path, &mut params) {
                if best_match.is_none() || route_path.len() > best_match.as_ref().unwrap().0.len() {
                    best_match = Some((route_path, handler));
                    best_match_params = params.clone();
                }
            }
        }

        match best_match {
            Some((_, handler)) => Some(handler(best_match_params)),
            None => None,
        }
    }

    fn match_path(&self, path: &String, route_path: &String, params: &mut HashMap<String, String>) -> bool {
        let path_segments: Vec<&str> = path.split('/').collect();
        let route_segments: Vec<&str> = route_path.split('/').collect();

        if path_segments.len() != route_segments.len() {
            return false;
        }

        for (i, segment) in route_segments.iter().enumerate() {
            if segment.starts_with(':') {
                let param_name = segment[1..].to_string();
                params.insert(param_name, path_segments[i].to_string());
            } else if *segment != path_segments[i] {
                return false;
            }
        }

        true
    }
}