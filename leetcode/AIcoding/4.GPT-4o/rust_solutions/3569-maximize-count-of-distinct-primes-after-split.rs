pub fn maximize_the_confusion(correct: String, incorrect: String) -> i32 {
    let mut count = 0;
    let mut freq = std::collections::HashMap::new();

    for c in correct.chars() {
        *freq.entry(c).or_insert(0) += 1;
    }

    for c in incorrect.chars() {
        count += 1;
        if let Some(&v) = freq.get(&c) {
            count += v;
        }
    }

    count
}