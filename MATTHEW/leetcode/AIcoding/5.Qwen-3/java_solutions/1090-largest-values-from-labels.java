public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> largestValuesFromLabels(int[] values, int[] labels, int numWanted, int pageSize) {
        List<int[]> list = new ArrayList<>();
        for (int i = 0; i < values.length; i++) {
            list.add(new int[]{values[i], labels[i]});
        }
        list.sort((a, b) -> b[0] - a[0]);

        Map<Integer, Integer> labelCount = new HashMap<>();
        List<Integer> result = new ArrayList<>();

        for (int[] item : list) {
            int value = item[0];
            int label = item[1];
            if (labelCount.getOrDefault(label, 0) < pageSize) {
                result.add(value);
                labelCount.put(label, labelCount.getOrDefault(label, 0) + 1);
                if (result.size() == numWanted) {
                    break;
                }
            }
        }

        return result;
    }
}
}