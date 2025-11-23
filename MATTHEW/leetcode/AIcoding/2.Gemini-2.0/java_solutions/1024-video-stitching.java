import java.util.Arrays;

class Solution {
    public int videoStitching(int[][] clips, int time) {
        Arrays.sort(clips, (a, b) -> a[0] - b[0]);
        int count = 0;
        int reach = 0;
        int maxReach = 0;
        int i = 0;
        while (reach < time) {
            maxReach = reach;
            while (i < clips.length && clips[i][0] <= reach) {
                maxReach = Math.max(maxReach, clips[i][1]);
                i++;
            }
            if (maxReach == reach) {
                return -1;
            }
            reach = maxReach;
            count++;
        }
        return count;
    }
}