struct Solution;

impl Solution {
    pub fn str_without_aab(a: i32, b: i32) -> String {
        let mut result = String::new();
        let mut a_count = a;
        let mut b_count = b;

        while a_count > 0 || b_count > 0 {
            if a_count >= b_count && a_count > 0 {
                result.push('a');
                a_count -= 1;
                if a_count > 0 {
                    result.push('a');
                    a_count -= 1;
                }
            } else if b_count > 0 {
                result.push('b');
                b_count -= 1;
                if b_count > 0 {
                    result.push('b');
                    b_count -= 1;
                }
            }
        }

        result
    }
}