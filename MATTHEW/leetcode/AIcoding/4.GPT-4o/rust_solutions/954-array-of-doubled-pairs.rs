use std::collections::HashMap;

pub fn can_reorder_doubled(arr: Vec<i32>) -> bool {
    let mut count = HashMap::new();
    for &num in &arr {
        *count.entry(num).or_insert(0) += 1;
    }

    let mut keys: Vec<i32> = count.keys().cloned().collect();
    keys.sort_by_key(|&x| x.abs());

    for &key in &keys {
        if let Some(&val) = count.get(&key) {
            if val > 0 {
                let double_key = key * 2;
                if let Some(&double_val) = count.get(&double_key) {
                    let min_count = val.min(double_val);
                    *count.get_mut(&key).unwrap() -= min_count;
                    *count.get_mut(&double_key).unwrap() -= min_count;
                } else {
                    return false;
                }
            }
        }
    }
    true
}