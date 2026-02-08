import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    public int largestValsFromLabels(int[] values, int[] labels, int numWanted, int useLimit) {
        int n = values.length;
        int[][] pairs = new int[n][2];
        for (int i = 0; i < n; i++) {
            pairs[i][0] = values[i];
            pairs[i][1] = labels[i];
        }

        Arrays.sort(pairs, (a, b) -> b[0] - a[0]);

        int sum = 0;
        int count = 0;
        Map<Integer, Integer> labelCounts = new HashMap<>();

        for (int i = 0; i < n; i++) {
            int value = pairs[i][0];
            int label = pairs[i][1];

            if (labelCounts.getOrDefault(label, 0) < useLimit) {
                sum += value;
                count++;
                labelCounts.put(label, labelCounts.getOrDefault(label, 0) + 1);
            }

            if (count == numWanted) {
                break;
            }
        }

        return sum;
    }
}