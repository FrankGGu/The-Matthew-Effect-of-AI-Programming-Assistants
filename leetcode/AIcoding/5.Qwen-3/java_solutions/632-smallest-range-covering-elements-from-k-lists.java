public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> smallestRange(List<List<Integer>> lists) {
        int k = lists.size();
        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int maxVal = Integer.MIN_VALUE;

        for (int i = 0; i < k; i++) {
            minHeap.offer(new int[]{lists.get(i).get(0), i, 0});
            maxVal = Math.max(maxVal, lists.get(i).get(0));
        }

        int rangeStart = 0;
        int rangeEnd = Integer.MAX_VALUE;

        while (true) {
            int[] current = minHeap.poll();
            int currentVal = current[0];
            int listIndex = current[1];
            int elementIndex = current[2];

            if (currentVal == Integer.MAX_VALUE) break;

            int currentRange = maxVal - currentVal;
            if (currentRange < (rangeEnd - rangeStart)) {
                rangeStart = currentVal;
                rangeEnd = maxVal;
            }

            if (elementIndex + 1 >= lists.get(listIndex).size()) break;

            int nextVal = lists.get(listIndex).get(elementIndex + 1);
            minHeap.offer(new int[]{nextVal, listIndex, elementIndex + 1});
            maxVal = Math.max(maxVal, nextVal);
        }

        return Arrays.asList(rangeStart, rangeEnd);
    }
}
}