import java.util.PriorityQueue;

class Solution {
    public int getNumberOfBacklogOrders(int[][] orders) {
        PriorityQueue<int[]> buy = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        PriorityQueue<int[]> sell = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        for (int[] order : orders) {
            int price = order[0];
            int amount = order[1];
            int type = order[2];

            if (type == 0) { // buy order
                while (amount > 0 && !sell.isEmpty() && sell.peek()[0] <= price) {
                    int[] sellOrder = sell.poll();
                    int minAmount = Math.min(amount, sellOrder[1]);
                    amount -= minAmount;
                    sellOrder[1] -= minAmount;
                    if (sellOrder[1] > 0) {
                        sell.offer(sellOrder);
                    }
                }
                if (amount > 0) {
                    buy.offer(new int[]{price, amount});
                }
            } else { // sell order
                while (amount > 0 && !buy.isEmpty() && buy.peek()[0] >= price) {
                    int[] buyOrder = buy.poll();
                    int minAmount = Math.min(amount, buyOrder[1]);
                    amount -= minAmount;
                    buyOrder[1] -= minAmount;
                    if (buyOrder[1] > 0) {
                        buy.offer(buyOrder);
                    }
                }
                if (amount > 0) {
                    sell.offer(new int[]{price, amount});
                }
            }
        }

        long res = 0;
        int mod = 1000000007;
        while (!buy.isEmpty()) {
            res += buy.poll()[1];
            res %= mod;
        }
        while (!sell.isEmpty()) {
            res += sell.poll()[1];
            res %= mod;
        }
        return (int) res;
    }
}