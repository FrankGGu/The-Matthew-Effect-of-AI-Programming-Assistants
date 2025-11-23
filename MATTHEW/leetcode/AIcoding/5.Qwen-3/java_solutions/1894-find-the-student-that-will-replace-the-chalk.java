public class Solution {
    public int chalkReplacer(int[] chalks, int k) {
        int total = 0;
        for (int chalk : chalks) {
            total += chalk;
        }
        k %= total;
        for (int i = 0; i < chalks.length; i++) {
            if (k < chalks[i]) {
                return i;
            }
            k -= chalks[i];
        }
        return -1;
    }
}