public class Solution {
    public int passThePillow(int n, int time) {
        int cycle = n - 1;
        int remainder = time % (2 * cycle);
        if (remainder <= cycle) {
            return remainder + 1;
        } else {
            return 2 * cycle - remainder + 1;
        }
    }
}