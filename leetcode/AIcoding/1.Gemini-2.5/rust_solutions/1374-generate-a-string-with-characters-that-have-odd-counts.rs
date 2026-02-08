impl Solution {
    pub fn generate_the_string(n: i32) -> String {
        if n % 2 == 1 {
            std::iter::repeat('a').take(n as usize).collect()
        } else {
            std::iter::repeat('a')
                .take((n - 1) as usize)
                .chain(std::iter::once('b'))
                .collect()
        }
    }
}