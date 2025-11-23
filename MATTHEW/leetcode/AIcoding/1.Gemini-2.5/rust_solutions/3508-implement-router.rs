use std::collections::HashMap;

struct Router {
    routes: Vec<(Vec<String>, String)>,
}

impl Router {
    fn new() -> Self {
        Router {
            routes: Vec::new(),
        }
    }

    fn add_route(&mut self, path: String, handler_id: String) {
        let segments: Vec<String> = path
            .trim_matches('/')
            .split('/')
            .filter(|s| !s.is_empty())
            .map(String::from)
            .collect();
        self.routes.push((segments, handler_id));
    }

    fn match_route(&self, path: String) -> Option<(String, HashMap<String, String>)> {
        let target_segments: Vec<String> = path
            .trim_matches('/')
            .split('/')
            .filter(|s| !s.is_empty())
            .map(String::from)
            .collect();

        for (route_segments, handler_id) in &self.routes {
            if route_segments.len() != target_segments.len() {
                continue;
            }

            let mut params = HashMap::new();
            let mut matched = true;

            for i in 0..route_segments.len() {
                let route_segment = &route_segments[i];
                let target_segment = &target_segments[i];

                if route_segment.starts_with('{') && route_segment.ends_with('}') {
                    let param_name = route_segment
                        .trim_start_matches('{')
                        .trim_end_matches('}')
                        .to_string();
                    params.insert(param_name, target_segment.clone());
                } else if route_segment != target_segment {
                    matched = false;
                    break;
                }
            }

            if matched {
                return Some((handler_id.clone(), params));
            }
        }

        None
    }
}