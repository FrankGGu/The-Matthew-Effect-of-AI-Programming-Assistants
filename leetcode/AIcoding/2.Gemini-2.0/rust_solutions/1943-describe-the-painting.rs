impl Solution {
    pub fn split_painting(segments: Vec<Vec<i64>>) -> Vec<Vec<i64>> {
        use std::collections::BTreeMap;

        let mut color_map: BTreeMap<i64, i64> = BTreeMap::new();
        for segment in &segments {
            *color_map.entry(segment[0]).or_insert(0) += segment[2];
            *color_map.entry(segment[1]).or_insert(0) -= segment[2];
        }

        let mut result: Vec<Vec<i64>> = Vec::new();
        let mut start = 0;
        let mut current_color = 0;

        let mut iter = color_map.iter();
        if let Some((&first_key, &first_value)) = iter.next() {
            start = first_key;
            current_color = first_value;
        }

        for (&key, &value) in iter {
            if current_color > 0 {
                result.push(vec![start, key, current_color]);
            }
            start = key;
            current_color += value;
        }

        result
    }
}