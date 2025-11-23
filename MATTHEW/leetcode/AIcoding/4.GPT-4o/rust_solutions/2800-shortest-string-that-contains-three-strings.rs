use std::collections::HashSet;

impl Solution {
    pub fn minimum_string(a: String, b: String, c: String) -> String {
        let mut min_str = String::from("~");
        let strings = vec![a, b, c];
        let n = strings.len();

        for i in 0..n {
            for j in 0..n {
                if i != j {
                    let k = 3 - i - j;
                    let merged = Self::merge(&strings[i], &strings[j]);
                    let final_str = Self::merge(&merged, &strings[k]);
                    if final_str < min_str {
                        min_str = final_str;
                    }
                }
            }
        }

        min_str
    }

    fn merge(a: &str, b: &str) -> String {
        let n = a.len();
        let m = b.len();

        let mut overlap = 0;
        for i in 0..n.min(m) {
            if &a[n - i - 1..] == &b[..i + 1] {
                overlap = i + 1;
            }
        }

        format!("{}{}", a, &b[overlap..])
    }
}