public class Solution {

import java.util.PriorityQueue;

public class Solution {
    public int minStoneSum(int[] piles, int k) {
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        for (int pile : piles) {
            maxHeap.offer(pile);
        }

        for (int i = 0; i < k; i++) {
            int current = maxHeap.poll();
            current -= current / 2;
            maxHeap.offer(current);
        }

        int sum = 0;
        while (!maxHeap.isEmpty()) {
            sum += maxHeap.poll();
        }
        return sum;
    }
}
}