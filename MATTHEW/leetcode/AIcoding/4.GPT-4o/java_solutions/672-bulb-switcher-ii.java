class Solution {
    public int flipLights(int n, int presses) {
        if (n == 0) return 0;
        if (presses == 0) return 1;
        if (presses == 1) return Math.min(n, 2);
        if (presses == 2) return n <= 3 ? n : 4;
        return n <= 3 ? n : 4;
    }
}