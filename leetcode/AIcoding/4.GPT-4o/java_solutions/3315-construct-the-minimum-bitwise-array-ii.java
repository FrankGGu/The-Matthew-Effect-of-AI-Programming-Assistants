class Solution {
    public int[] constructArray(int n, int k) {
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            if (k > 0) {
                result[i] = (i % 2 == 0) ? (i / 2 + 1) : (n - (i / 2));
                if (i % 2 == 1) k--;
            } else {
                result[i] = i + 1;
            }
        }
        return result;
    }
}