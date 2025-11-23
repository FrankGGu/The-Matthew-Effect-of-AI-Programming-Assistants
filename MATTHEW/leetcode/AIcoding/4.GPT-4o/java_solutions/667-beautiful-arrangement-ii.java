class Solution {
    public int[] constructArray(int n, int k) {
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) {
                result[i] = (i / 2) + 1;
            } else {
                result[i] = n - (i / 2);
            }
        }
        for (int i = n - k; i < n; i++) {
            if (i % 2 == 0) {
                result[i] = (i - n + k + 1);
            } else {
                result[i] = (n - (i - n + k + 1));
            }
        }
        return result;
    }
}