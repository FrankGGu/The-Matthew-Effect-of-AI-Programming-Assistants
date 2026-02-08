pub fn shortest_supersequence_frequency(seq1: Vec<i32>, seq2: Vec<i32>) -> Vec<i32> {
    use std::collections::HashMap;

    let mut freq_map = HashMap::new();
    let mut min_len = std::i32::MAX;
    let mut result = Vec::new();

    for &num in &seq1 {
        *freq_map.entry(num).or_insert(0) += 1;
    }

    let mut left = 0;
    let mut count = 0;
    let mut required = freq_map.len();

    for right in 0..seq2.len() {
        let right_num = seq2[right];
        if let Some(entry) = freq_map.get_mut(&right_num) {
            if *entry > 0 {
                count += 1;
            }
            *entry -= 1;
        }

        while count == required {
            if right - left + 1 < min_len {
                min_len = right - left + 1;
                result = seq2[left..=right].to_vec();
            }
            let left_num = seq2[left];
            if let Some(entry) = freq_map.get_mut(&left_num) {
                if *entry == 0 {
                    count -= 1;
                }
                *entry += 1;
            }
            left += 1;
        }
    }
    result
}