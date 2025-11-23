impl Solution {
    pub fn flower_game(n: i32, m: i32) -> i64 {
        let n_even = n / 2;
        let n_odd = n - n_even;
        let m_even = m / 2;
        let m_odd = m - m_even;

        (n_even as i64 * m_odd as i64) + (n_odd as i64 * m_even as i64)
    }
}