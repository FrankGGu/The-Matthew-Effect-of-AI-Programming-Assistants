pub fn num_rabbits(answers: Vec<i32>) -> i32 {
    let mut count = std::collections::HashMap::new();
    for answer in answers {
        *count.entry(answer).or_insert(0) += 1;
    }
    count.iter().map(|(&k, &v)| (v + k) / (k + 1) * (k + 1)).sum()
}