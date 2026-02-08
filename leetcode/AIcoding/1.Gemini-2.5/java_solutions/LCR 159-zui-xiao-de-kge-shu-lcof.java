import java.util.PriorityQueue;

class Solution {
    public int inventoryManagement(int[] stock, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();

        for (int price : stock) {
            pq.offer(price);
            if (pq.size() > k) {
                pq.poll();
            }
        }

        long sum = 0;
        long MOD = 1_000_000_007; 

        while (!pq.isEmpty()) {
            sum = (sum + pq.poll()) % MOD;
        }

        return (int) sum;
    }
}