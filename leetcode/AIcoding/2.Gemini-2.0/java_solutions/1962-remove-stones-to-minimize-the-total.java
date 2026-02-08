import java.util.PriorityQueue;

class Solution {
    public int minStoneSum(int[] piles, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        int sum = 0;
        for (int pile : piles) {
            pq.offer(pile);
            sum += pile;
        }

        for (int i = 0; i < k; i++) {
            int largest = pq.poll();
            int remove = largest / 2;
            sum -= remove;
            pq.offer(largest - remove);
        }

        return sum;
    }
}