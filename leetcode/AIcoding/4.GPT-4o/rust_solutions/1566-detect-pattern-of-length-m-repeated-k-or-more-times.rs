pub fn contains_pattern(s: String, m: i32, k: i32) -> bool {
    let n = s.len();
    let m = m as usize;
    let k = k as usize;

    if m * k > n {
        return false;
    }

    for i in 0..=n - m * k {
        let pattern = &s[i..i + m];
        let mut count = 0;

        while &s[i + count * m..i + (count + 1) * m] == pattern {
            count += 1;
            if count >= k {
                return true;
            }
        }
    }

    false
}