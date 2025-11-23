import java.util.ArrayList;
import java.util.List;

public class Solution {
    public List<Integer> busiestServers(int k, int[] arrival, int[] load) {
        int[] count = new int[k];
        int[] endTime = new int[k];
        List<Integer> result = new ArrayList<>();
        int maxRequests = 0;

        for (int i = 0; i < arrival.length; i++) {
            int idx = i % k;
            while (idx < k && endTime[idx] <= arrival[i]) {
                idx++;
            }
            if (idx == 0) {
                continue;
            }
            idx--;
            count[idx]++;
            endTime[idx] = arrival[i] + load[i];
            maxRequests = Math.max(maxRequests, count[idx]);
        }

        for (int i = 0; i < k; i++) {
            if (count[i] == maxRequests) {
                result.add(i);
            }
        }

        return result;
    }
}