use std::collections::HashMap;

impl Solution {
    pub fn convert_units(value: f64, source_unit: String, target_unit: String) -> f64 {
        let mut to_base_factors: HashMap<String, f64> = HashMap::new();
        to_base_factors.insert("mm".to_string(), 0.001);
        to_base_factors.insert("cm".to_string(), 0.01);
        to_base_factors.insert("m".to_string(), 1.0);
        to_base_factors.insert("km".to_string(), 1000.0);
        to_base_factors.insert("inch".to_string(), 0.0254);
        to_base_factors.insert("ft".to_string(), 0.3048);
        to_base_factors.insert("yard".to_string(), 0.9144);
        to_base_factors.insert("mile".to_string(), 1609.34);

        let source_factor = *to_base_factors.get(&source_unit).unwrap();
        let target_factor = *to_base_factors.get(&target_unit).unwrap();

        let value_in_base_unit = value * source_factor;

        value_in_base_unit / target_factor
    }
}