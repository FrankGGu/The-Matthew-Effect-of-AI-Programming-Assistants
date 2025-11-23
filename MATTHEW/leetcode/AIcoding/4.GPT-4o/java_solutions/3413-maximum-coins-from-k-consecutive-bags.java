import java.util.PriorityQueue;

class Solution {
    public int maxCoins(int[] piles, int k) {
        int n = piles.length;
        Arrays.sort(piles);
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int i = n - 2; i >= n - 3 * k; i--) {
            minHeap.offer(piles[i]);
        }
        int totalCoins = 0;
        for (int i = 0; i < k; i++) {
            totalCoins += minHeap.poll();
        }
        return totalCoins;
    }
}