pub fn minimum_time(s: String) -> i32 {
    let n = s.len();
    let mut time = vec![0; n + 1];

    for i in 0..n {
        time[i + 1] = time[i] + if s.as_bytes()[i] == b'1' { 1 } else { 0 };
    }

    let mut result = i32::MAX;

    for i in 0..=n {
        let revert_time = time[i] + (n - i) as i32;
        result = result.min(revert_time);
    }

    result
}