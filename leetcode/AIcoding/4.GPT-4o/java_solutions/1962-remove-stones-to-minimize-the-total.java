import java.util.Arrays;

class Solution {
    public int minStoneSum(int[] piles, int k) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        for (int pile : piles) {
            maxHeap.offer(pile);
        }
        for (int i = 0; i < k; i++) {
            int largest = maxHeap.poll();
            maxHeap.offer(largest - largest / 2);
        }
        int total = 0;
        while (!maxHeap.isEmpty()) {
            total += maxHeap.poll();
        }
        return total;
    }
}