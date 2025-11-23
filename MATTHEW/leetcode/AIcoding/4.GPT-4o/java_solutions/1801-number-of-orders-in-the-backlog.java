import java.util.PriorityQueue;

class Solution {
    public int getNumberOfBacklogOrders(int[][] orders) {
        PriorityQueue<int[]> buy = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        PriorityQueue<int[]> sell = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int mod = 1_000_000_007;

        for (int[] order : orders) {
            if (order[2] == 0) {
                while (!sell.isEmpty() && sell.peek()[0] <= order[0] && order[1] > 0) {
                    int[] temp = sell.poll();
                    if (temp[1] > order[1]) {
                        temp[1] -= order[1];
                        buy.offer(temp);
                        order[1] = 0;
                    } else {
                        order[1] -= temp[1];
                    }
                }
                if (order[1] > 0) {
                    buy.offer(new int[]{order[0], order[1]});
                }
            } else {
                while (!buy.isEmpty() && buy.peek()[0] >= order[0] && order[1] > 0) {
                    int[] temp = buy.poll();
                    if (temp[1] > order[1]) {
                        temp[1] -= order[1];
                        sell.offer(temp);
                        order[1] = 0;
                    } else {
                        order[1] -= temp[1];
                    }
                }
                if (order[1] > 0) {
                    sell.offer(new int[]{order[0], order[1]});
                }
            }
        }

        long total = 0;
        while (!buy.isEmpty()) {
            total = (total + buy.poll()[1]) % mod;
        }
        while (!sell.isEmpty()) {
            total = (total + sell.poll()[1]) % mod;
        }

        return (int) total;
    }
}