import java.util.PriorityQueue;

class Solution {
    public int findMinimumCost(int[] nums) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.add(num);
        }
        int cost = 0;
        while (minHeap.size() > 1) {
            int first = minHeap.poll();
            int second = minHeap.poll();
            int sum = first + second;
            cost += sum;
            minHeap.add(sum);
        }
        return cost;
    }
}