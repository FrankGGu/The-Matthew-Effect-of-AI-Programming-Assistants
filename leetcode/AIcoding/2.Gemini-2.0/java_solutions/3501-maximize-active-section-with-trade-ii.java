class Solution {
    public int maximizeActiveSections(int[] sat, int k) {
        int n = sat.length;
        int[] diff = new int[2 * n];
        for (int i = 0; i < n; i++) {
            diff[i] = sat[i];
            diff[i + n] = sat[i];
        }

        int maxActive = 0;
        for (int i = 0; i < n; i++) {
            int active = 0;
            for (int j = i; j < i + n; j++) {
                if (diff[j] <= k) {
                    active++;
                }
            }
            maxActive = Math.max(maxActive, active);
        }

        return maxActive;
    }
}