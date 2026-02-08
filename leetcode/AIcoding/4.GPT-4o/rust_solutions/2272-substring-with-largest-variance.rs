impl Solution {
    pub fn largest_variance(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let unique_chars: Vec<char> = chars.iter().cloned().collect::<std::collections::HashSet<_>>().into_iter().collect();
        let mut max_variance = 0;

        for i in 0..unique_chars.len() {
            for j in 0..unique_chars.len() {
                if i != j {
                    let a = unique_chars[i];
                    let b = unique_chars[j];
                    let (mut count_a, mut count_b, mut current_variance) = (0, 0, 0);

                    for &c in &chars {
                        if c == a {
                            count_a += 1;
                        }
                        if c == b {
                            count_b += 1;
                        }
                        if count_b > 0 {
                            current_variance = count_a - count_b;
                            max_variance = max_variance.max(current_variance);
                        }
                        if count_a < count_b {
                            count_a = 0;
                            count_b = 0;
                        }
                    }
                }
            }
        }

        max_variance
    }
}