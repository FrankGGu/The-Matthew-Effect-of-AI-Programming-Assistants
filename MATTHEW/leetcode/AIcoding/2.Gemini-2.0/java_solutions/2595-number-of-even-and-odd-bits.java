class Solution {
    public int[] evenOddBit(int n) {
        int even = 0;
        int odd = 0;
        int bitPos = 0;
        while (n > 0) {
            if ((n & 1) == 1) {
                if (bitPos % 2 == 0) {
                    even++;
                } else {
                    odd++;
                }
            }
            n >>= 1;
            bitPos++;
        }
        return new int[]{even, odd};
    }
}