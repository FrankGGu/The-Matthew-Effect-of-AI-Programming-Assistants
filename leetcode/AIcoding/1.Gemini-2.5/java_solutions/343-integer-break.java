class Solution {
    public int integerBreak(int n) {
        if (n == 2) {
            return 1;
        }
        if (n == 3) {
            return 2;
        }

        int remainder = n % 3;
        if (remainder == 0) {
            return (int) Math.pow(3, n / 3);
        } else if (remainder == 1) {
            return (int) Math.pow(3, (n - 4) / 3) * 4;
        } else { // remainder == 2
            return (int) Math.pow(3, (n - 2) / 3) * 2;
        }
    }
}