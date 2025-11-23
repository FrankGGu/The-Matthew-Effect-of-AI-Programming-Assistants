class Solution {
    public long pickGifts(int[] gifts, int k) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        for (int gift : gifts) {
            maxHeap.offer(gift);
        }
        for (int i = 0; i < k; i++) {
            int max = maxHeap.poll();
            int remaining = (int) Math.sqrt(max);
            maxHeap.offer(remaining);
        }
        long sum = 0;
        while (!maxHeap.isEmpty()) {
            sum += maxHeap.poll();
        }
        return sum;
    }
}