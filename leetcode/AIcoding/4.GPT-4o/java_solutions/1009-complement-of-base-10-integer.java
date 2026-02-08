class Solution {
    public int bitwiseComplement(int N) {
        if (N == 0) return 1;
        int mask = 1;
        while (mask <= N) {
            mask <<= 1;
        }
        return (mask - 1) ^ N;
    }
}