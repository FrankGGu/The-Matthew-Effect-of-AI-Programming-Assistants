import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public long pickGifts(int[] gifts, int k) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        for (int gift : gifts) {
            maxHeap.offer(gift);
        }

        for (int i = 0; i < k; i++) {
            int richestGift = maxHeap.poll();
            int newGift = (int) Math.floor(Math.sqrt(richestGift));
            maxHeap.offer(newGift);
        }

        long totalGifts = 0;
        while (!maxHeap.isEmpty()) {
            totalGifts += maxHeap.poll();
        }

        return totalGifts;
    }
}