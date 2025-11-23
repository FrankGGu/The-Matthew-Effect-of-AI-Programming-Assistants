class Solution {
    public int minStoneSum(int[] piles, int k) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        for (int pile : piles) {
            maxHeap.offer(pile);
        }
        for (int i = 0; i < k; i++) {
            int current = maxHeap.poll();
            int removed = current / 2;
            maxHeap.offer(current - removed);
        }
        int total = 0;
        while (!maxHeap.isEmpty()) {
            total += maxHeap.poll();
        }
        return total;
    }
}