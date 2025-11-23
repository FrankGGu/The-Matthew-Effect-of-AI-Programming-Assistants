impl Solution {
    pub fn split_into_fibonacci(s: String) -> Vec<i32> {
        let n = s.len();
        let mut result = vec![];

        for i in 1..n {
            for j in i + 1..n {
                let (first, second) = (&s[0..i], &s[i..j]);

                if (first.len() > 1 && first.starts_with('0')) || (second.len() > 1 && second.starts_with('0')) {
                    continue;
                }

                let mut a = first.parse::<i32>().unwrap();
                let mut b = second.parse::<i32>().unwrap();
                result.push(a);
                result.push(b);

                let mut k = j;
                while k < n {
                    let c = a + b;
                    let c_str = c.to_string();
                    let c_len = c_str.len();

                    if k + c_len > n || &s[k..k + c_len] != c_str {
                        break;
                    }

                    result.push(c);
                    k += c_len;
                    a = b;
                    b = c;
                }

                if k == n {
                    return result;
                }
                result.truncate(2);
            }
        }

        vec![]
    }
}