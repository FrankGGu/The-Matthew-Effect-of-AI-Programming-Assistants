use std::collections::HashMap;

struct RangeFreqQuery {
    map: HashMap<i32, Vec<usize>>,
}

impl RangeFreqQuery {
    fn new(arr: Vec<i32>) -> Self {
        let mut map = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            map.entry(num).or_insert(Vec::new()).push(i);
        }
        RangeFreqQuery { map }
    }

    fn query(&self, left: i32, right: i32, value: i32) -> i32 {
        if let Some(indices) = self.map.get(&value) {
            let left = left as usize;
            let right = right as usize;
            let l = match indices.binary_search(&left) {
                Ok(i) | Err(i) => i,
            };
            let r = match indices.binary_search(&right) {
                Ok(i) => i + 1,
                Err(i) => i,
            };
            (r - l) as i32
        } else {
            0
        }
    }
}