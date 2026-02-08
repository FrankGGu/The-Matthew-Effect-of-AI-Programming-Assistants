class Solution {
    public int minimumTimeToBreakLocks(int n, int k, int[] locks) {
        if (k == n) {
            return 0;
        }
        if (locks.length == 0) {
            return Math.min(k, n - k);
        }

        int minTime = Integer.MAX_VALUE;

        for (int i = 0; i < (1 << locks.length); i++) {
            int count = 0;
            for (int j = 0; j < locks.length; j++) {
                if ((i & (1 << j)) != 0) {
                    count++;
                }
            }

            int[] selectedLocks = new int[count];
            int index = 0;
            for (int j = 0; j < locks.length; j++) {
                if ((i & (1 << j)) != 0) {
                    selectedLocks[index++] = locks[j];
                }
            }

            int unlocked = k;
            for (int lock : selectedLocks) {
                if (lock <= k) {
                    unlocked--;
                } else {
                    unlocked++;
                }
            }

            minTime = Math.min(minTime, count + Math.min(unlocked, n - unlocked));
        }

        return minTime;
    }
}