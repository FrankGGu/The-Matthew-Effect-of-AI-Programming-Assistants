import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int largestValsFromLabels(int[] values, int[] labels, int numWanted, int useLimit) {
        int n = values.length;
        int[][] items = new int[n][2]; 

        for (int i = 0; i < n; i++) {
            items[i][0] = values[i];
            items[i][1] = labels[i];
        }

        Arrays.sort(items, (a, b) -> b[0] - a[0]);

        int currentSum = 0;
        int itemsSelectedCount = 0;
        Map<Integer, Integer> labelCounts = new HashMap<>();

        for (int i = 0; i < n; i++) {
            if (itemsSelectedCount == numWanted) {
                break;
            }

            int value = items[i][0];
            int label = items[i][1];

            if (labelCounts.getOrDefault(label, 0) < useLimit) {
                currentSum += value;
                itemsSelectedCount++;
                labelCounts.put(label, labelCounts.getOrDefault(label, 0) + 1);
            }
        }

        return currentSum;
    }
}