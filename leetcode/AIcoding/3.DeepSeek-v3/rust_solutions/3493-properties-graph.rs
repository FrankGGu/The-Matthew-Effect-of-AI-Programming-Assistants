use std::collections::HashMap;

struct PropertiesGraph {
    graph: HashMap<String, HashMap<String, String>>,
}

impl PropertiesGraph {
    fn new() -> Self {
        PropertiesGraph {
            graph: HashMap::new(),
        }
    }

    fn set_property(&mut self, entity: String, property: String, value: String) {
        self.graph
            .entry(entity)
            .or_insert_with(HashMap::new)
            .insert(property, value);
    }

    fn get_property(&self, entity: String, property: String) -> String {
        self.graph
            .get(&entity)
            .and_then(|props| props.get(&property))
            .cloned()
            .unwrap_or_else(|| "".to_string())
    }

    fn get_entities_with_property(&self, property: String, value: String) -> Vec<String> {
        self.graph
            .iter()
            .filter_map(|(entity, props)| {
                if props.get(&property) == Some(&value) {
                    Some(entity.clone())
                } else {
                    None
                }
            })
            .collect()
    }

    fn get_related_entities(&self, entity: String, property: String) -> Vec<String> {
        let value = self.get_property(entity.clone(), property.clone());
        if value.is_empty() {
            return Vec::new();
        }
        self.get_entities_with_property(property, value)
            .into_iter()
            .filter(|e| *e != entity)
            .collect()
    }
}