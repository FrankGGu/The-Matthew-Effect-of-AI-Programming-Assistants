import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public int minStoneSum(int[] piles, int k) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        for (int pile : piles) {
            maxHeap.add(pile);
        }

        for (int i = 0; i < k; i++) {
            int currentMax = maxHeap.poll();
            int stonesToRemove = currentMax / 2;
            int newStones = currentMax - stonesToRemove;
            maxHeap.add(newStones);
        }

        int totalStones = 0;
        while (!maxHeap.isEmpty()) {
            totalStones += maxHeap.poll();
        }

        return totalStones;
    }
}