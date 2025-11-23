use std::collections::BinaryHeap;

pub fn reorganize_string(s: String) -> String {
    let mut count = vec![0; 26];
    for c in s.chars() {
        count[c as usize - 'a' as usize] += 1;
    }

    let mut heap = BinaryHeap::new();
    for (i, &c) in count.iter().enumerate() {
        if c > 0 {
            heap.push((c, i));
        }
    }

    let mut result = String::new();
    let mut prev = (0, 0);

    while let Some((freq, idx)) = heap.pop() {
        result.push((idx as u8 + b'a') as char);
        if prev.0 > 0 {
            heap.push(prev);
        }
        prev = (freq - 1, idx);
    }

    if result.len() == s.len() {
        result
    } else {
        String::new()
    }
}