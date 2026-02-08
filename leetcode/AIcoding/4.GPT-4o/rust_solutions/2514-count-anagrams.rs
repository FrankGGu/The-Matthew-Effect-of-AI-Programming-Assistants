use std::collections::HashMap;

pub fn count_anagrams(words: Vec<String>) -> i32 {
    let modulo = 1_000_000_007;
    let factorials = (0..27).map(|i| (1..=i).product::<i32>()).collect::<Vec<_>>();

    let mut total_count = 1;

    for word in words {
        let mut char_count = HashMap::new();
        for ch in word.chars() {
            *char_count.entry(ch).or_insert(0) += 1;
        }

        let mut numerator = factorials[word.len() as usize];
        let mut denominator = 1;

        for &count in char_count.values() {
            denominator = denominator * factorials[count as usize] % modulo;
        }

        total_count = total_count * numerator * mod_inverse(denominator, modulo) % modulo;
    }

    total_count
}

fn mod_inverse(a: i32, m: i32) -> i32 {
    let mut m0 = m;
    let mut y = 0;
    let mut x = 1;

    if m == 1 {
        return 0;
    }

    let mut a = a % m;

    while a > 1 {
        let q = a / m0;
        let t = m0;

        m0 = a % m0;
        a = t;
        t = y;

        y = x - q * y;
        x = t;
    }

    if x < 0 {
        x += m;
    }

    x
}