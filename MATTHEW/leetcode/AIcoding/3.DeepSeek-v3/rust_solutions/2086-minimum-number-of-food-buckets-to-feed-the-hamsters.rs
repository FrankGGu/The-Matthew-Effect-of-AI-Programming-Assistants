impl Solution {
    pub fn minimum_buckets(hamsters: String) -> i32 {
        let chars: Vec<char> = hamsters.chars().collect();
        let n = chars.len();
        let mut buckets = 0;
        let mut i = 0;

        while i < n {
            if chars[i] == 'H' {
                if i + 1 < n && chars[i + 1] == '.' {
                    buckets += 1;
                    i += 3;
                } else if i > 0 && chars[i - 1] == '.' {
                    buckets += 1;
                    i += 1;
                } else {
                    return -1;
                }
            } else {
                i += 1;
            }
        }

        buckets
    }
}