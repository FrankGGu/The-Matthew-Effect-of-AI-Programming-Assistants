import java.util.PriorityQueue;

class Solution {
    public int maxProfit(int[] inventory, int orders) {
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        for (int i : inventory) {
            pq.offer(i);
        }

        long profit = 0;
        int mod = 1000000007;

        while (orders > 0) {
            int top = pq.poll();
            if (pq.isEmpty() || top - pq.peek() <= orders) {
                int diff = pq.isEmpty() ? top : top - pq.peek();
                int count = Math.min(orders, diff);
                long sum = (long) (top + (top - count + 1)) * count / 2;
                profit = (profit + sum) % mod;
                orders -= count;
                if (!pq.isEmpty()) {
                    pq.offer(top - count);
                }

            } else {
                profit = (profit + top) % mod;
                top--;
                orders--;
                pq.offer(top);
            }
        }

        return (int) profit;
    }
}