impl Solution {

use std::collections::HashMap;

struct Route {
    handler: Box<dyn Fn(Vec<String>)>,
}

struct Router {
    routes: HashMap<String, Route>,
}

impl Router {
    fn new() -> Self {
        Router {
            routes: HashMap::new(),
        }
    }

    fn add_route(&mut self, path: &str, handler: Box<dyn Fn(Vec<String>)>) {
        self.routes.insert(path.to_string(), Route { handler });
    }

    fn handle(&self, path: &str, params: Vec<String>) {
        if let Some(route) = self.routes.get(path) {
            (route.handler)(params);
        }
    }
}
}