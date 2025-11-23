class Solution {
    public int maxDistance(int[] charge, int[] usage, int[] cost) {
        int n = charge.length;
        int low = 0, high = n;
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canComplete(charge, usage, cost, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }

    private boolean canComplete(int[] charge, int[] usage, int[] cost, int k) {
        int n = charge.length;
        long currentCharge = charge[0];

        for (int i = 0; i < n; i++) {
            int idx = i % n;
            int nextIdx = (i + k) % n;

            if (currentCharge < usage[idx]) {
                return false;
            }
            currentCharge -= usage[idx];
            currentCharge += charge[nextIdx];
            currentCharge = Math.min(currentCharge, (long)cost[nextIdx]);
        }

        return true;
    }
}