class Solution {
    public int[] decrypt(int[] code, int k) {
        int n = code.length;
        int[] result = new int[n];
        if (k == 0) return result;

        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int j = 1; j <= Math.abs(k); j++) {
                sum += code[(i + (k > 0 ? j : -j) + n) % n];
            }
            result[i] = sum;
        }
        return result;
    }
}