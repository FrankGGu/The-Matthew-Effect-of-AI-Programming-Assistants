impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn rearrange_barcodes(barcodes: Vec<i32>) -> Vec<i32> {
        if barcodes.is_empty() {
            return vec![];
        }

        let mut count = HashMap::new();
        for &b in &barcodes {
            *count.entry(b).or_insert(0) += 1;
        }

        let mut max_char = barcodes[0];
        let mut max_count = 0;
        for (&k, &v) in &count {
            if v > max_count {
                max_count = v;
                max_char = k;
            }
        }

        let mut result = vec![0; barcodes.len()];
        let mut index = 0;

        while max_count > 0 && index < barcodes.len() {
            result[index] = max_char;
            index += 2;
            max_count -= 1;
        }

        for (&k, &v) in &count {
            if k == max_char {
                continue;
            }
            let mut count = v;
            while count > 0 && index < barcodes.len() {
                result[index] = k;
                index += 2;
                count -= 1;
            }
        }

        result
    }
}
}