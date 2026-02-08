use std::collections::HashMap;

pub fn rearrange_barcodes(barcodes: Vec<i32>) -> Vec<i32> {
    let mut freq = HashMap::new();
    for &barcode in &barcodes {
        *freq.entry(barcode).or_insert(0) += 1;
    }

    let mut sorted_barcodes: Vec<_> = freq.into_iter().collect();
    sorted_barcodes.sort_by(|a, b| b.1.cmp(&a.1));

    let mut result = vec![0; barcodes.len()];
    let n = result.len();
    let mut index = 0;

    for (barcode, count) in sorted_barcodes {
        for _ in 0..count {
            result[index] = barcode;
            index += 2;
            if index >= n {
                index = 1;
            }
        }
    }

    result
}