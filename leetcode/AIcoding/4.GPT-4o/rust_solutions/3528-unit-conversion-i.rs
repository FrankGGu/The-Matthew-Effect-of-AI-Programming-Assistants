impl Solution {
    pub fn convert(unit: String, conversion: String) -> f64 {
        let conversion_map: std::collections::HashMap<_, _> = [
            ("inches", 0.0254),
            ("feet", 0.3048),
            ("yards", 0.9144),
            ("miles", 1609.34),
            ("millimeters", 0.001),
            ("centimeters", 0.01),
            ("meters", 1.0),
            ("kilometers", 1000.0),
        ].iter().cloned().collect();

        let value: f64 = unit.parse().unwrap();
        let unit_from = unit.split_whitespace().last().unwrap();
        let unit_to = conversion.split_whitespace().last().unwrap();

        let meters = value * conversion_map[unit_from];
        meters / conversion_map[unit_to]
    }
}