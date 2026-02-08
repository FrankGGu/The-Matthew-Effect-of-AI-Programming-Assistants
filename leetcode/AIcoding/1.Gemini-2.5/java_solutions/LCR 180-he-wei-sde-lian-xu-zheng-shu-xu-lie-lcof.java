import java.util.PriorityQueue;

class Solution {
    public int minCost(int[] files) {
        if (files == null || files.length <= 1) {
            return 0;
        }

        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int file : files) {
            pq.offer(file);
        }

        int totalCost = 0;
        while (pq.size() > 1) {
            int first = pq.poll();
            int second = pq.poll();
            int currentCost = first + second;
            totalCost += currentCost;
            pq.offer(currentCost);
        }

        return totalCost;
    }
}