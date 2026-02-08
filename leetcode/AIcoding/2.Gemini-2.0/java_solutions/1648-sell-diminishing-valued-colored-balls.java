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
                int num = Math.min(diff, orders);
                long sum = (long) num * (top + (long) top - num + 1) / 2;
                profit = (profit + sum) % mod;
                orders -= num;
                if (!pq.isEmpty()) {
                    pq.offer(top - num);
                }
            } else {
                profit = (profit + (long) orders * top) % mod;
                orders = 0;
            }
        }

        return (int) profit;
    }
}