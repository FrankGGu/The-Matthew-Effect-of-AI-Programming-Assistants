class Solution {
    public boolean judgeSquareSum(int c) {
        for (long a = 0; a * a <= c; a++) {
            int b_squared = c - (int)(a * a);
            double b_double = Math.sqrt(b_squared);
            long b = (long) b_double;
            if (b * b == b_squared) {
                return true;
            }
        }
        return false;
    }
}