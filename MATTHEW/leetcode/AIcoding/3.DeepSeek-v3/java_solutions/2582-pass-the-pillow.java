class Solution {
    public int passThePillow(int n, int time) {
        int cycle = 2 * (n - 1);
        time %= cycle;
        if (time <= n - 1) {
            return time + 1;
        } else {
            return 2 * (n - 1) - time + 1;
        }
    }
}