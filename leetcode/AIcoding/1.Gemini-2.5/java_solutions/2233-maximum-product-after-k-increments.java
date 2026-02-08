import java.util.PriorityQueue;

class Solution {
    public int maximumProduct(int[] nums, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int num : nums) {
            pq.offer(num);
        }

        for (int i = 0; i < k; i++) {
            int min = pq.poll();
            pq.offer(min + 1);
        }

        long product = 1;
        int MOD = 1_000_000_007;

        while (!pq.isEmpty()) {
            product = (product * pq.poll()) % MOD;
        }

        return (int) product;
    }
}