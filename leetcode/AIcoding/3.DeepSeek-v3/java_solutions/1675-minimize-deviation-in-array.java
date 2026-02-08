import java.util.PriorityQueue;

class Solution {
    public int minimumDeviation(int[] nums) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        int min = Integer.MAX_VALUE;
        for (int num : nums) {
            if (num % 2 != 0) {
                num *= 2;
            }
            maxHeap.offer(num);
            min = Math.min(min, num);
        }

        int res = Integer.MAX_VALUE;
        while (true) {
            int max = maxHeap.poll();
            res = Math.min(res, max - min);
            if (max % 2 != 0) {
                break;
            }
            max /= 2;
            min = Math.min(min, max);
            maxHeap.offer(max);
        }
        return res;
    }
}