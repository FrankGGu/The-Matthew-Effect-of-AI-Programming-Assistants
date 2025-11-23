public class Solution {
    public int minFlips(int a, int b, int c) {
        int flips = 0;
        for (int i = 0; i < 32; i++) {
            boolean aBit = (a & (1 << i)) != 0;
            boolean bBit = (b & (1 << i)) != 0;
            boolean cBit = (c & (1 << i)) != 0;
            boolean abOr = aBit || bBit;
            if (abOr != cBit) {
                if (cBit) {
                    flips += 1;
                } else {
                    flips += (aBit ? 1 : 0) + (bBit ? 1 : 0);
                }
            }
        }
        return flips;
    }
}