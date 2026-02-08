pub fn count_ways(s: String) -> i32 {
    let n = s.len();
    let s = s.as_bytes();
    let mut left_count = vec![0; n + 1];
    let mut right_count = vec![0; n + 1];

    for i in 1..=n {
        left_count[i] = left_count[i - 1] + if s[i - 1] == b'1' { 1 } else { 0 };
    }

    for i in (0..n).rev() {
        right_count[i] = right_count[i + 1] + if s[i] == b'1' { 1 } else { 0 };
    }

    let mut result = 0;
    for i in 1..n {
        if s[i - 1] == b'1' && s[i] == b'0' {
            result += left_count[i] * right_count[i];
        }
    }

    (result % 1_000_000_007) as i32
}