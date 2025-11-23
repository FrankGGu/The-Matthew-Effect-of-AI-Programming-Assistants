import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public int minimumDeviation(int[] nums) {
        PriorityQueue<Integer> pq = new PriorityQueue<>(Collections.reverseOrder()); // Max-heap
        int minVal = Integer.MAX_VALUE;

        for (int num : nums) {
            if (num % 2 != 0) { // If odd, multiply by 2 to make it even
                num *= 2;
            }
            pq.add(num);
            minVal = Math.min(minVal, num);
        }

        int minDeviation = Integer.MAX_VALUE;

        while (true) {
            int currentMax = pq.poll();
            minDeviation = Math.min(minDeviation, currentMax - minVal);

            if (currentMax % 2 != 0) { // If currentMax is odd, it cannot be divided further
                break;
            }

            // If currentMax is even, divide it by 2
            currentMax /= 2;
            pq.add(currentMax);
            minVal = Math.min(minVal, currentMax); // Update minVal if the new value is smaller
        }

        return minDeviation;
    }
}