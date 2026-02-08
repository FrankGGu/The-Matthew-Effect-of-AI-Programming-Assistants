impl Solution {
    pub fn str_without3a3b(a: i32, b: i32) -> String {
        let mut result = String::new();
        let (mut a, mut b) = (a, b);

        while a > 0 || b > 0 {
            if a > b {
                if a > 0 {
                    result.push('a');
                    a -= 1;
                }
                if a > 0 {
                    result.push('a');
                    a -= 1;
                }
                if b > 0 {
                    result.push('b');
                    b -= 1;
                }
            } else {
                if b > 0 {
                    result.push('b');
                    b -= 1;
                }
                if b > 0 {
                    result.push('b');
                    b -= 1;
                }
                if a > 0 {
                    result.push('a');
                    a -= 1;
                }
            }
        }

        result
    }
}