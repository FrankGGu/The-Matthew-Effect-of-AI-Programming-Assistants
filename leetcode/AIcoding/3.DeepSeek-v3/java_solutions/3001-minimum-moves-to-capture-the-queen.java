class Solution {
    public int minMovesToCaptureTheQueen(int a, int b, int c, int d, int e, int f) {
        if (a == e) {
            if (c == a && ((d > b && d < f) || (d < b && d > f))) {
                return 2;
            } else {
                return 1;
            }
        }
        if (b == f) {
            if (d == f && ((c > a && c < e) || (c < a && c > e))) {
                return 2;
            } else {
                return 1;
            }
        }
        if (Math.abs(c - e) == Math.abs(d - f)) {
            if (Math.abs(a - c) == Math.abs(b - d) && Math.abs(a - e) == Math.abs(b - f) && ((c > a && c < e) || (c < a && c > e))) {
                return 2;
            } else {
                return 1;
            }
        }
        return 2;
    }
}