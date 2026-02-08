class Solution {
    public int passThePillow(int n, int time) {
        int cycle = (n - 1) * 2;
        int rem = time % cycle;
        if (rem < n) {
            return rem + 1;
        } else {
            return n - (rem - (n - 1));
        }
    }
}