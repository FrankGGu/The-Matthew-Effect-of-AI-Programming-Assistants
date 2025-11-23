impl Solution {
    pub fn shortest_uncommon_substring(source: String, target: String) -> i32 {
        let source_chars: Vec<char> = source.chars().collect();
        let target_chars: Vec<char> = target.chars().collect();
        let n = source_chars.len();
        let m = target_chars.len();

        for len in 1..=m {
            for i in 0..=m - len {
                let sub: String = target_chars[i..i + len].iter().collect();
                let mut found = false;
                for j in 0..=n - len {
                    let source_sub: String = source_chars[j..j + len].iter().collect();
                    if source_sub == sub {
                        found = true;
                        break;
                    }
                }
                if !found {
                    return len as i32;
                }
            }
        }

        -1
    }
}