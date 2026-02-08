impl Solution {
    pub fn construct_string_with_minimum_cost(a: i32, b: i32, c: i32) -> String {
        let mut counts = vec![a, b, c];
        counts.sort();
        let mut result = String::new();
        let mut counts = counts.into_iter().collect::<Vec<_>>();
        let c = counts.pop().unwrap();
        let b = counts.pop().unwrap();
        let a = counts.pop().unwrap();

        let diff = c - b - a;
        if diff >= 2 {
            for _ in 0..b + a + 1 {
                result.push('c');
            }
            for _ in 0..b {
                result.push('b');
            }
            for _ in 0..a {
                result.push('a');
            }
        } else {
            for _ in 0..c {
                result.push('c');
            }
            for _ in 0..b {
                result.push('b');
            }
            for _ in 0..a {
                result.push('a');
            }
        }

        result
    }
}