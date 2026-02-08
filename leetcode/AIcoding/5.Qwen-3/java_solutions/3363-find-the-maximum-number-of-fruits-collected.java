public class Solution {

import java.util.*;

public class Solution {
    public int maxTotalFruits(int[][] positions, int[] amount) {
        Map<Integer, Integer> posToAmount = new HashMap<>();
        for (int i = 0; i < positions.length; i++) {
            posToAmount.put(positions[i][0], amount[i]);
        }

        List<Integer> sortedPositions = new ArrayList<>(posToAmount.keySet());
        Collections.sort(sortedPositions);

        int n = sortedPositions.size();
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + posToAmount.get(sortedPositions.get(i));
        }

        int result = 0;
        for (int i = 0; i < n; i++) {
            int left = i;
            int right = n - 1;
            int best = i;
            while (left <= right) {
                int mid = (left + right) / 2;
                int total = prefix[mid + 1] - prefix[i];
                if (total > 0) {
                    best = mid;
                    left = mid + 1;
                } else {
                    right = mid - 1;
                }
            }
            result = Math.max(result, prefix[best + 1] - prefix[i]);
        }

        return result;
    }
}
}