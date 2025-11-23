class Solution {
    public int minimumSum(int n, int k) {
        boolean[] used = new boolean[n + 1];
        int sum = 0;
        for (int i = 1; i <= n; i++) {
            if (!used[i]) {
                sum += i;
                used[i] = true;
                if (i + k <= n) {
                    used[i + k] = true;
                }
            }
        }
        return sum;
    }
}