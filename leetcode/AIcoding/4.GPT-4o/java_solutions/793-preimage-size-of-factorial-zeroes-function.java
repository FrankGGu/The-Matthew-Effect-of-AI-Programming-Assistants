class Solution {
    public int preimageSizeFZF(int K) {
        return countZeros(K + 1) - countZeros(K);
    }

    private long countZeros(long x) {
        long count = 0;
        for (long i = 5; i <= x; i *= 5) {
            count += x / i;
        }
        return count;
    }
}