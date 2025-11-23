use std::collections::HashMap;

struct RangeFreqQuery {
    val_to_indices: HashMap<i32, Vec<i32>>,
}

impl RangeFreqQuery {
    fn new(arr: Vec<i32>) -> Self {
        let mut val_to_indices: HashMap<i32, Vec<i32>> = HashMap::new();
        for (i, &val) in arr.iter().enumerate() {
            val_to_indices.entry(val).or_default().push(i as i32);
        }
        RangeFreqQuery { val_to_indices }
    }

    fn query(&self, left: i32, right: i32, value: i32) -> i32 {
        if let Some(indices) = self.val_to_indices.get(&value) {
            let start_idx = indices.partition_point(|&x| x < left);
            let end_idx = indices.partition_point(|&x| x <= right);

            (end_idx - start_idx) as i32
        } else {
            0
        }
    }
}