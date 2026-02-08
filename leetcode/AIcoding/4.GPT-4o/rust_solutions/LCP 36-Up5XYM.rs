pub fn max_deck_count(deck: Vec<i32>) -> i32 {
    use std::collections::HashMap;

    let mut count = HashMap::new();
    for card in deck {
        *count.entry(card).or_insert(0) += 1;
    }

    let mut freqs: Vec<i32> = count.values().cloned().collect();
    freqs.sort_unstable();

    let mut g = freqs[0];
    for &f in freqs.iter().skip(1) {
        g = gcd(g, f);
    }

    g
}

fn gcd(a: i32, b: i32) -> i32 {
    if b == 0 { a } else { gcd(b, a % b) }
}