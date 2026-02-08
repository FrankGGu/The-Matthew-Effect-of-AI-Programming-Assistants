import java.util.Arrays;

public class Solution {
    public int videoStitching(int[][] clips, int T) {
        Arrays.sort(clips, (a, b) -> Integer.compare(a[0], b[0]));
        int end = 0, farthest = 0, count = 0, i = 0;

        while (end < T) {
            while (i < clips.length && clips[i][0] <= end) {
                farthest = Math.max(farthest, clips[i][1]);
                i++;
            }
            if (farthest <= end) return -1;
            end = farthest;
            count++;
        }
        return count;
    }
}