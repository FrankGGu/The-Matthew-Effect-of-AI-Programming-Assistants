impl Solution {
    pub fn str_without3a3b(a: i32, b: i32) -> String {
        let mut res = String::new();
        let mut a = a;
        let mut b = b;
        let mut write_a = false;
        let mut write_b = false;

        while a > 0 || b > 0 {
            write_a = false;
            write_b = false;

            if a > b {
                if res.len() >= 2 && res.chars().nth(res.len() - 1).unwrap() == 'a' && res.chars().nth(res.len() - 2).unwrap() == 'a' {
                    write_b = true;
                } else {
                    write_a = true;
                }
            } else {
                if res.len() >= 2 && res.chars().nth(res.len() - 1).unwrap() == 'b' && res.chars().nth(res.len() - 2).unwrap() == 'b' {
                    write_a = true;
                } else {
                    write_b = true;
                }
            }

            if write_a {
                res.push('a');
                a -= 1;
            } else if write_b {
                res.push('b');
                b -= 1;
            }
        }

        res
    }
}