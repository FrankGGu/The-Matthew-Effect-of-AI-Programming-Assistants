class Solution {
    public int maxEvents(int[][] events) {
        Arrays.sort(events, (a, b) -> a[0] - b[0]);
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        int i = 0, res = 0, n = events.length;
        for (int d = 1; d <= 100000; d++) {
            while (!minHeap.isEmpty() && minHeap.peek() < d) {
                minHeap.poll();
            }
            while (i < n && events[i][0] == d) {
                minHeap.offer(events[i++][1]);
            }
            if (!minHeap.isEmpty()) {
                minHeap.poll();
                res++;
            }
        }
        return res;
    }
}