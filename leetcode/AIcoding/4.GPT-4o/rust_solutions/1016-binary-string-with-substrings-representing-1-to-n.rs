impl Solution {
    pub fn query_string(s: String, n: i32) -> bool {
        let mut seen = vec![false; (n + 1) as usize];
        let len = s.len();

        for i in 0..len {
            for j in i..len {
                if j - i + 1 > 20 {
                    break;
                }
                let num = isize::from_str_radix(&s[i..=j], 2).unwrap();
                if num > n as isize {
                    break;
                }
                if num > 0 {
                    seen[num as usize] = true;
                }
            }
        }

        seen.iter().skip(1).all(|&x| x)
    }
}