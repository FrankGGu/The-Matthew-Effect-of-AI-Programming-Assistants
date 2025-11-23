import java.util.PriorityQueue;
import java.util.Comparator;

class Solution {
    public int getNumberOfBacklogOrders(int[][] orders) {
        PriorityQueue<int[]> buyOrders = new PriorityQueue<>((a, b) -> b[0] - a[0]); // Max-heap for buy orders (highest price first)
        PriorityQueue<int[]> sellOrders = new PriorityQueue<>((a, b) -> a[0] - b[0]); // Min-heap for sell orders (lowest price first)

        long MOD = 1_000_000_007;

        for (int[] order : orders) {
            int price = order[0];
            int amount = order[1];
            int type = order[2]; // 0 for buy, 1 for sell

            if (type == 0) { // Buy order
                while (amount > 0 && !sellOrders.isEmpty() && sellOrders.peek()[0] <= price) {
                    int[] sellOrder = sellOrders.poll();
                    int sellPrice = sellOrder[0];
                    int sellAmount = sellOrder[1];

                    int matchedAmount = Math.min(amount, sellAmount);
                    amount -= matchedAmount;
                    sellAmount -= matchedAmount;

                    if (sellAmount > 0) {
                        sellOrders.offer(new int[]{sellPrice, sellAmount});
                    }
                }
                if (amount > 0) {
                    buyOrders.offer(new int[]{price, amount});
                }
            } else { // Sell order
                while (amount > 0 && !buyOrders.isEmpty() && buyOrders.peek()[0] >= price) {
                    int[] buyOrder = buyOrders.poll();
                    int buyPrice = buyOrder[0];
                    int buyAmount = buyOrder[1];

                    int matchedAmount = Math.min(amount, buyAmount);
                    amount -= matchedAmount;
                    buyAmount -= matchedAmount;

                    if (buyAmount > 0) {
                        buyOrders.offer(new int[]{buyPrice, buyAmount});
                    }
                }
                if (amount > 0) {
                    sellOrders.offer(new int[]{price, amount});
                }
            }
        }

        long totalBacklog = 0;
        for (int[] order : buyOrders) {
            totalBacklog = (totalBacklog + order[1]) % MOD;
        }
        for (int[] order : sellOrders) {
            totalBacklog = (totalBacklog + order[1]) % MOD;
        }

        return (int) totalBacklog;
    }
}