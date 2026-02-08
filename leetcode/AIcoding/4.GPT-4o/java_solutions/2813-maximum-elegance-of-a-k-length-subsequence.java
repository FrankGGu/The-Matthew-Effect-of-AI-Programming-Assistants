import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public long maximumElegance(int[][] items, int k) {
        Arrays.sort(items, (a, b) -> Integer.compare(b[1], a[1]));
        long sum = 0, elegance = 0;
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();

        for (int i = 0; i < items.length; i++) {
            if (minHeap.size() < k) {
                minHeap.offer(items[i][0]);
                sum += items[i][1];
                elegance += items[i][1];
            } else if (!minHeap.isEmpty() && items[i][0] > minHeap.peek()) {
                sum += items[i][1] - items[minHeap.poll()][1];
                minHeap.offer(items[i][0]);
            }
        }

        elegance += (long) (minHeap.size() == k ? 0 : minHeap.size()) * (minHeap.size() == k ? 1 : 0);
        return sum + elegance;
    }
}