import java.util.*;

class Solution {
    public int largestValsFromLabels(int[] values, int[] labels, int numWanted, int useLimit) {
        Map<Integer, Integer> labelCount = new HashMap<>();
        List<int[]> valueLabelPairs = new ArrayList<>();

        for (int i = 0; i < values.length; i++) {
            valueLabelPairs.add(new int[]{values[i], labels[i]});
        }

        valueLabelPairs.sort((a, b) -> b[0] - a[0]);

        int totalValue = 0;
        int count = 0;

        for (int[] pair : valueLabelPairs) {
            if (count >= numWanted) break;
            int value = pair[0];
            int label = pair[1];

            labelCount.put(label, labelCount.getOrDefault(label, 0) + 1);
            if (labelCount.get(label) <= useLimit) {
                totalValue += value;
                count++;
            }
        }

        return totalValue;
    }
}