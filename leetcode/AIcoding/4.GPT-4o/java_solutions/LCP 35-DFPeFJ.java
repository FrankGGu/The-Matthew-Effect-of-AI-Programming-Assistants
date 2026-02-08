class Solution {
    public boolean canReach(int[] stations, int fuel) {
        int n = stations.length;
        int maxReach = 0;
        for (int i = 0; i < n; i++) {
            if (i > maxReach) return false;
            maxReach = Math.max(maxReach, i + fuel);
            fuel -= (i < n - 1) ? (stations[i + 1] - stations[i]) : 0;
        }
        return true;
    }
}