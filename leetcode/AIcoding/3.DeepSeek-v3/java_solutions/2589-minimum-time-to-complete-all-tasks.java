class Solution {
    public int findMinimumTime(int[][] tasks) {
        Arrays.sort(tasks, (a, b) -> a[1] - b[1]);
        boolean[] time = new boolean[2001];
        int res = 0;
        for (int[] task : tasks) {
            int start = task[0], end = task[1], duration = task[2];
            int alreadyCovered = 0;
            for (int i = start; i <= end; i++) {
                if (time[i]) {
                    alreadyCovered++;
                }
            }
            if (alreadyCovered >= duration) {
                continue;
            }
            int remaining = duration - alreadyCovered;
            for (int i = end; i >= start && remaining > 0; i--) {
                if (!time[i]) {
                    time[i] = true;
                    remaining--;
                    res++;
                }
            }
        }
        return res;
    }
}