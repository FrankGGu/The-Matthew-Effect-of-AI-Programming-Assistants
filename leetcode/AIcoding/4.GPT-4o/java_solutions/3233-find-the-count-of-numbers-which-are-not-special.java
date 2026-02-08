class Solution {
    public int countNonSpecialNumbers(int n) {
        boolean[] isSpecial = new boolean[n + 1];
        for (int i = 2; i <= n; i++) {
            if (!isSpecial[i]) {
                for (int j = i; j <= n; j += i) {
                    isSpecial[j] = true;
                }
            }
        }
        int count = 0;
        for (int i = 1; i <= n; i++) {
            if (!isSpecial[i]) {
                count++;
            }
        }
        return count;
    }
}