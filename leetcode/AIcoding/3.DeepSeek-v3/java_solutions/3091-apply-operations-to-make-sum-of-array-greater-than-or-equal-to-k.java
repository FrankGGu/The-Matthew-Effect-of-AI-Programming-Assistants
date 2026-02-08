class Solution {
    public int minOperations(int k) {
        int minOps = Integer.MAX_VALUE;
        for (int a = 1; a <= k; a++) {
            int ops = (a - 1) + ((k + a - 1) / a - 1);
            if (ops < minOps) {
                minOps = ops;
            }
        }
        return minOps;
    }
}