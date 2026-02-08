import java.util.PriorityQueue;

class Solution {
    public int getNumberOfBacklogOrders(int[][] orders) {
        PriorityQueue<int[]> buyOrders = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        PriorityQueue<int[]> sellOrders = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        for (int[] order : orders) {
            int price = order[0];
            int amount = order[1];
            int type = order[2];

            if (type == 0) { // Buy order
                while (amount > 0 && !sellOrders.isEmpty() && sellOrders.peek()[0] <= price) {
                    int[] sellOrder = sellOrders.peek();
                    int sellPrice = sellOrder[0];
                    int sellAmount = sellOrder[1];

                    if (amount >= sellAmount) {
                        amount -= sellAmount;
                        sellOrders.poll();
                    } else {
                        sellOrder[1] -= amount;
                        amount = 0;
                    }
                }
                if (amount > 0) {
                    buyOrders.offer(new int[]{price, amount});
                }
            } else { // Sell order
                while (amount > 0 && !buyOrders.isEmpty() && buyOrders.peek()[0] >= price) {
                    int[] buyOrder = buyOrders.peek();
                    int buyPrice = buyOrder[0];
                    int buyAmount = buyOrder[1];

                    if (amount >= buyAmount) {
                        amount -= buyAmount;
                        buyOrders.poll();
                    } else {
                        buyOrder[1] -= amount;
                        amount = 0;
                    }
                }
                if (amount > 0) {
                    sellOrders.offer(new int[]{price, amount});
                }
            }
        }

        long totalOrders = 0;
        while (!buyOrders.isEmpty()) {
            totalOrders = (totalOrders + buyOrders.poll()[1]) % 1000000007;
        }
        while (!sellOrders.isEmpty()) {
            totalOrders = (totalOrders + sellOrders.poll()[1]) % 1000000007;
        }

        return (int) totalOrders;
    }
}