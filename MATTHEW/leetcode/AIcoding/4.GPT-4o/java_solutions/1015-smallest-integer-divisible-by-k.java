class Solution {
    public int smallestRepunitDivByK(int K) {
        if (K % 2 == 0 || K % 5 == 0) return -1;
        int remainder = 1, length = 1;
        while (remainder % K != 0) {
            remainder = (remainder * 10 + 1) % K;
            length++;
        }
        return length;
    }
}