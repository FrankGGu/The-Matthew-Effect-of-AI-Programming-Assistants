use std::collections::HashSet;

pub fn count_words(words1: Vec<String>, words2: Vec<String>) -> i32 {
    let mut count1 = HashSet::new();
    let mut count2 = HashSet::new();

    for word in words1 {
        *count1.entry(word).or_insert(0) += 1;
    }

    for word in words2 {
        *count2.entry(word).or_insert(0) += 1;
    }

    count1.retain(|_, &mut v| v == 1);
    count2.retain(|_, &mut v| v == 1);

    count1.intersection(&count2).count() as i32
}