public class Solution {

import java.util.Arrays;

public class Solution {
    public int videoStitching(int[][] clips, int time) {
        Arrays.sort(clips, (a, b) -> a[0] - b[0]);
        int res = 0;
        int end = 0;
        int i = 0;
        while (end < time) {
            int maxEnd = end;
            while (i < clips.length && clips[i][0] <= end) {
                maxEnd = Math.max(maxEnd, clips[i][1]);
                i++;
            }
            if (maxEnd == end) {
                return -1;
            }
            end = maxEnd;
            res++;
        }
        return res;
    }
}
}