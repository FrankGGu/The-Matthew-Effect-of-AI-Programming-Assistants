public class Solution {

import java.util.*;

public class Solution {
    public int minimumDeviation(int[] nums) {
        PriorityQueue<int[]> maxHeap = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        int minVal = Integer.MAX_VALUE;

        for (int num : nums) {
            if (num % 2 != 0) {
                num *= 2;
            }
            maxHeap.offer(new int[]{num, num});
            minVal = Math.min(minVal, num);
        }

        int minDeviation = Integer.MAX_VALUE;

        while (!maxHeap.isEmpty()) {
            int[] curr = maxHeap.poll();
            int currentMax = curr[0];
            minDeviation = Math.min(minDeviation, currentMax - minVal);

            if (currentMax % 2 == 0) {
                int newNum = currentMax / 2;
                minVal = Math.min(minVal, newNum);
                maxHeap.offer(new int[]{newNum, curr[1]});
            } else {
                break;
            }
        }

        return minDeviation;
    }
}
}