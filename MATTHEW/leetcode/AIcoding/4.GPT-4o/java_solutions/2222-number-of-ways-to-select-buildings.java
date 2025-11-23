class Solution {
    public int countWays(int[] buildings) {
        int n = buildings.length;
        long mod = 1000000007;
        long left = 0, right = 0;

        for (int b : buildings) {
            if (b == 1) left++;
        }

        for (int b : buildings) {
            if (b == 1) right++;
        }

        if (left == 0 || right == 0) return 0;

        long ans = 1;
        for (int i = 1; i <= left; i++) {
            ans = ans * i % mod;
        }

        for (int i = 1; i <= right; i++) {
            ans = ans * i % mod;
        }

        return (int) ans;
    }
}