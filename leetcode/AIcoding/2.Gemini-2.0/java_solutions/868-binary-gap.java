class Solution {
    public int binaryGap(int n) {
        int last = -1;
        int ans = 0;
        for (int i = 0; n != 0; ++i) {
            if ((n & 1) != 0) {
                if (last != -1) {
                    ans = Math.max(ans, i - last);
                }
                last = i;
            }
            n >>= 1;
        }
        return ans;
    }
}