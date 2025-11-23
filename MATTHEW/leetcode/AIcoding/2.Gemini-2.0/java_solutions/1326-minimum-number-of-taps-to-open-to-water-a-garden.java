class Solution {
    public int minTaps(int n, int[] ranges) {
        int[] maxReach = new int[n + 1];
        for (int i = 0; i <= n; i++) {
            int left = Math.max(0, i - ranges[i]);
            int right = Math.min(n, i + ranges[i]);
            maxReach[left] = Math.max(maxReach[left], right);
        }

        int taps = 0;
        int currentReach = 0;
        int nextReach = 0;

        for (int i = 0; i < n; i++) {
            nextReach = Math.max(nextReach, maxReach[i]);
            if (i == currentReach) {
                if (currentReach == nextReach) {
                    return -1;
                }
                taps++;
                currentReach = nextReach;
            }
        }

        return taps;
    }
}