import java.util.PriorityQueue;

class Solution {
    public int maximumProduct(int[] nums, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int num : nums) {
            pq.offer(num);
        }
        while (k > 0) {
            int min = pq.poll();
            pq.offer(min + 1);
            k--;
        }
        long product = 1;
        int mod = 1000000007;
        while (!pq.isEmpty()) {
            product = (product * pq.poll()) % mod;
        }
        return (int) product;
    }
}