public class Solution {

import java.util.Arrays;

public class Solution {
    public int eliminateMaximum(int[] dist, int[] speed) {
        int n = dist.length;
        for (int i = 0; i < n; i++) {
            dist[i] = (dist[i] + speed[i] - 1) / speed[i];
        }
        Arrays.sort(dist);
        for (int i = 0; i < n; i++) {
            if (dist[i] <= i) {
                return i;
            }
        }
        return n;
    }
}
}