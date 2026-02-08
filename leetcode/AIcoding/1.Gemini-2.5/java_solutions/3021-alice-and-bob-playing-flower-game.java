class Solution {
    public long flowerGame(int n, int m) {
        long n_long = n;
        long m_long = m;

        long n_odd = (n_long + 1) / 2;
        long n_even = n_long / 2;

        long m_odd = (m_long + 1) / 2;
        long m_even = m_long / 2;

        return n_odd * m_even + n_even * m_odd;
    }
}