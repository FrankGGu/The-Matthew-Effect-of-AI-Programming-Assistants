pub fn count_substrings(s: String, k: i32) -> i32 {
    let n = s.len();
    let mut result = 0;
    let mut count = vec![0; 26];
    let mut left = 0;

    for right in 0..n {
        count[(s.as_bytes()[right] - b'a') as usize] += 1;

        while count.iter().filter(|&&c| c > 0).count() > k as usize {
            count[(s.as_bytes()[left] - b'a') as usize] -= 1;
            left += 1;
        }

        result += right - left + 1;
    }

    result
}