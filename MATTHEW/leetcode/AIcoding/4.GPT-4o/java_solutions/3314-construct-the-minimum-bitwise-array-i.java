class Solution {
    public int[] constructArray(int n, int m) {
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            if (i < m) {
                result[i] = i + 1;
            } else {
                result[i] = m;
            }
        }
        return result;
    }
}