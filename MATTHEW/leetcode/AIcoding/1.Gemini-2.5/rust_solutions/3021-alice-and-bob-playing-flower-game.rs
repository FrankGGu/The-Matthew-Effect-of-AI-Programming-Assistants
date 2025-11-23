impl Solution {
    pub fn flower_game(n: i32, m: i32) -> i64 {
        let n_long = n as i64;
        let m_long = m as i64;

        let n_odd_count = (n_long + 1) / 2;
        let n_even_count = n_long / 2;

        let m_odd_count = (m_long + 1) / 2;
        let m_even_count = m_long / 2;

        // Alice wins if (x + y) is odd. This happens if:
        // 1. x is odd and y is even
        // 2. x is even and y is odd
        n_odd_count * m_even_count + n_even_count * m_odd_count
    }
}