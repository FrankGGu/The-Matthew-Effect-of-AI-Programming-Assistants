class Solution {
    public int flipLights(int n, int m) {
        if (m == 0) {
            return 1;
        }

        if (n == 1) {
            return 2;
        } else if (n == 2) {
            if (m == 1) {
                return 3;
            } else { // m >= 2
                return 4;
            }
        } else { // n >= 3
            if (m == 1) {
                return 4;
            } else if (m == 2) {
                return 7;
            } else { // m >= 3
                return 8;
            }
        }
    }
}