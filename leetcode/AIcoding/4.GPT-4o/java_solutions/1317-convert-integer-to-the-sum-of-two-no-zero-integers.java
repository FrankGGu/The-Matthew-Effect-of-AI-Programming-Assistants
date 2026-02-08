class Solution {
    public int[] getNoZeroIntegers(int n) {
        for (int i = 1; i < n; i++) {
            if (isNoZero(i) && isNoZero(n - i)) {
                return new int[]{i, n - i};
            }
        }
        return new int[0];
    }

    private boolean isNoZero(int num) {
        while (num > 0) {
            if (num % 10 == 0) {
                return false;
            }
            num /= 10;
        }
        return true;
    }
}