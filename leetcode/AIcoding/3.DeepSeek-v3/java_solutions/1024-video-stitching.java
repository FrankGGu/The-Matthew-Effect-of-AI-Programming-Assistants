class Solution {
    public int videoStitching(int[][] clips, int time) {
        Arrays.sort(clips, (a, b) -> a[0] - b[0]);
        int res = 0;
        int currentEnd = 0, nextEnd = 0;
        int i = 0, n = clips.length;

        while (currentEnd < time) {
            while (i < n && clips[i][0] <= currentEnd) {
                nextEnd = Math.max(nextEnd, clips[i][1]);
                i++;
            }
            if (currentEnd == nextEnd) {
                return -1;
            }
            currentEnd = nextEnd;
            res++;
        }
        return res;
    }
}