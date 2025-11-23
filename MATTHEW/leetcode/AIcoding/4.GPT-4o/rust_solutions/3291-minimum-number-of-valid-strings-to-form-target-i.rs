pub fn min_number_of_strings(target: String, strings: Vec<String>) -> i32 {
    use std::collections::HashMap;

    let mut freq = HashMap::new();
    for ch in target.chars() {
        *freq.entry(ch).or_insert(0) += 1;
    }

    let mut result = 0;
    let mut covered = HashMap::new();

    for s in strings {
        let mut count = HashMap::new();
        for ch in s.chars() {
            *count.entry(ch).or_insert(0) += 1;
        }
        let mut can_cover = true;
        for (&ch, &req) in freq.iter() {
            if count.get(&ch).unwrap_or(&0) < &req {
                can_cover = false;
                break;
            }
        }
        if can_cover {
            result += 1;
            for (ch, &cnt) in count.iter() {
                *covered.entry(ch).or_insert(0) += cnt;
            }
        }
    }

    for (&ch, &req) in freq.iter() {
        if covered.get(&ch).unwrap_or(&0) < &req {
            return -1;
        }
    }

    result
}