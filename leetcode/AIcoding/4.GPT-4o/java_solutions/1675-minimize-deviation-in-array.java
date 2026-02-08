import java.util.PriorityQueue;

public class Solution {
    public int minimumDeviation(int[] nums) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        int min = Integer.MAX_VALUE;

        for (int num : nums) {
            if (num % 2 == 0) {
                maxHeap.offer(num);
                min = Math.min(min, num);
            } else {
                maxHeap.offer(num * 2);
                min = Math.min(min, num * 2);
            }
        }

        int minDeviation = Integer.MAX_VALUE;

        while (!maxHeap.isEmpty()) {
            int max = maxHeap.poll();
            minDeviation = Math.min(minDeviation, max - min);
            if (max % 2 == 0) {
                min = Math.min(min, max / 2);
                maxHeap.offer(max / 2);
            } else {
                break;
            }
        }

        return minDeviation;
    }
}