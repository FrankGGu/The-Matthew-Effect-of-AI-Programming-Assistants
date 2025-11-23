import java.util.*;

class Solution {
    public int[] smallestRange(List<List<Integer>> nums) {
        PriorityQueue<int[]> minHeap = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int max = Integer.MIN_VALUE;
        int minRange = Integer.MAX_VALUE;
        int start = -1, end = -1;

        for (int i = 0; i < nums.size(); i++) {
            int val = nums.get(i).get(0);
            minHeap.offer(new int[]{val, i, 0});
            max = Math.max(max, val);
        }

        while (minHeap.size() == nums.size()) {
            int[] curr = minHeap.poll();
            int currVal = curr[0];
            int listIdx = curr[1];
            int elemIdx = curr[2];

            if (max - currVal < minRange) {
                minRange = max - currVal;
                start = currVal;
                end = max;
            }

            if (elemIdx + 1 < nums.get(listIdx).size()) {
                int nextVal = nums.get(listIdx).get(elemIdx + 1);
                minHeap.offer(new int[]{nextVal, listIdx, elemIdx + 1});
                max = Math.max(max, nextVal);
            }
        }

        return new int[]{start, end};
    }
}