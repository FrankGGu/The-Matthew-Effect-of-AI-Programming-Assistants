pub fn champion_title(titles: Vec<String>) -> String {
    let mut count = std::collections::HashMap::new();
    for title in titles {
        *count.entry(title).or_insert(0) += 1;
    }
    count.into_iter().max_by_key(|&(_, v)| v).unwrap().0
}