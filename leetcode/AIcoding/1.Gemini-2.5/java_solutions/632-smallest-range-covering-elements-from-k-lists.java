import java.util.List;
import java.util.PriorityQueue;

class Solution {
    public int[] smallestRange(List<List<Integer>> nums) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int maxVal = Integer.MIN_VALUE;
        int rangeStart = 0;
        int rangeEnd = Integer.MAX_VALUE;

        for (int i = 0; i < nums.size(); i++) {
            pq.offer(new int[]{nums.get(i).get(0), i, 0});
            maxVal = Math.max(maxVal, nums.get(i).get(0));
        }

        while (pq.size() == nums.size()) {
            int[] current = pq.poll();
            int minVal = current[0];
            int listIndex = current[1];
            int elementIndex = current[2];

            if (maxVal - minVal < rangeEnd - rangeStart) {
                rangeStart = minVal;
                rangeEnd = maxVal;
            }

            if (elementIndex + 1 < nums.get(listIndex).size()) {
                int nextVal = nums.get(listIndex).get(elementIndex + 1);
                pq.offer(new int[]{nextVal, listIndex, elementIndex + 1});
                maxVal = Math.max(maxVal, nextVal);
            } else {
                break;
            }
        }

        return new int[]{rangeStart, rangeEnd};
    }
}