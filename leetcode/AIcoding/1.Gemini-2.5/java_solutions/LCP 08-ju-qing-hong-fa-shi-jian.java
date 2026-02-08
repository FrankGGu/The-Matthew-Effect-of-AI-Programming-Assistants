import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

class Solution {
    public int[] getTriggerTime(int[][] quests, int[][] upgrades) {
        TreeMap<Integer, long[]> timeToDelta = new TreeMap<>();
        for (int[] upgrade : upgrades) {
            int time = upgrade[0];
            long dr = upgrade[1];
            long dg = upgrade[2];
            long db = upgrade[3];

            timeToDelta.computeIfAbsent(time, k -> new long[3]);
            long[] delta = timeToDelta.get(time);
            delta[0] += dr;
            delta[1] += dg;
            delta[2] += db;
        }

        List<long[]> effectivePoints = new ArrayList<>();
        effectivePoints.add(new long[]{0, 0, 0, 0}); 

        long currentR = 0;
        long currentG = 0;
        long currentB = 0;

        for (Map.Entry<Integer, long[]> entry : timeToDelta.entrySet()) {
            int time = entry.getKey();
            long[] delta = entry.getValue();

            currentR += delta[0];
            currentG += delta[1];
            currentB += delta[2];

            effectivePoints.add(new long[]{time, currentR, currentG, currentB});
        }

        int[] ans = new int[quests.length];
        for (int i = 0; i < quests.length; i++) {
            long rq = quests[i][0];
            long gq = quests[i][1];
            long bq = quests[i][2];

            int low = 0;
            int high = effectivePoints.size() - 1;
            int resultTime = -1;

            while (low <= high) {
                int mid = low + (high - low) / 2;
                long[] point = effectivePoints.get(mid);

                if (point[1] >= rq && point[2] >= gq && point[3] >= bq) {
                    resultTime = (int) point[0]; 
                    high = mid - 1;              
                } else {
                    low = mid + 1;               
                }
            }
            ans[i] = resultTime;
        }

        return ans;
    }
}