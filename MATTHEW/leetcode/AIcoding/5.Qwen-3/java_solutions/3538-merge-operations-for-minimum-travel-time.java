public class Solution {

import java.util.*;

public class Solution {
    public int minTravelTime(int[] stations, int k) {
        int n = stations.length;
        List<int[]> intervals = new ArrayList<>();

        for (int i = 0; i < n - 1; i++) {
            intervals.add(new int[]{stations[i], stations[i + 1]});
        }

        while (intervals.size() > 1 && k > 0) {
            int maxIndex = 0;
            int maxDiff = intervals.get(0)[1] - intervals.get(0)[0];

            for (int i = 1; i < intervals.size(); i++) {
                int diff = intervals.get(i)[1] - intervals.get(i)[0];
                if (diff > maxDiff) {
                    maxDiff = diff;
                    maxIndex = i;
                }
            }

            int[] merged = new int[]{intervals.get(maxIndex)[0], intervals.get(maxIndex + 1)[1]};
            intervals.set(maxIndex, merged);
            intervals.remove(maxIndex + 1);
            k--;
        }

        int result = 0;
        for (int[] interval : intervals) {
            result += interval[1] - interval[0];
        }

        return result;
    }
}
}