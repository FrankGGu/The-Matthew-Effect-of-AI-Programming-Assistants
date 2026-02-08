class Solution {
    public boolean isThree(int n) {
        if (n < 4) {
            return false;
        }

        int root = (int) Math.sqrt(n);

        if (root * root != n) {
            return false;
        }

        if (root <= 1) {
            return false;
        }

        for (int i = 2; i * i <= root; i++) {
            if (root % i == 0) {
                return false;
            }
        }

        return true;
    }
}