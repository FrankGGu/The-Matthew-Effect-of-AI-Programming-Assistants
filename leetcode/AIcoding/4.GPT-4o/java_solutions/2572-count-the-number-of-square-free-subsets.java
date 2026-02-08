class Solution {
    public int squareFreeSubsets(int[] nums) {
        int MOD = 1000000007;
        int[] count = new int[1001];
        for (int num : nums) {
            count[num]++;
        }

        int[] squareFree = new int[1001];
        for (int i = 1; i < squareFree.length; i++) {
            if (isSquareFree(i)) {
                squareFree[i] = 1;
            }
        }

        int total = 1;
        for (int i = 1; i < squareFree.length; i++) {
            if (squareFree[i] == 1 && count[i] > 0) {
                total = total * (count[i] + 1) % MOD;
            }
        }

        return (total - 1 + MOD) % MOD;
    }

    private boolean isSquareFree(int n) {
        for (int i = 2; i * i <= n; i++) {
            if (n % (i * i) == 0) {
                return false;
            }
        }
        return true;
    }
}