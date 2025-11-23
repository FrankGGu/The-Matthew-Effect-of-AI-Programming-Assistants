public class Solution {

import java.util.*;

public class Solution {
    public int numberofBacklogOrders(int[][] orders) {
        PriorityQueue<int[]> buy = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        PriorityQueue<int[]> sell = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        for (int[] order : orders) {
            int price = order[0];
            int amount = order[1];
            int type = order[2];

            if (type == 0) {
                while (amount > 0 && !sell.isEmpty() && sell.peek()[0] <= price) {
                    int[] top = sell.poll();
                    if (top[1] > amount) {
                        top[1] -= amount;
                        amount = 0;
                        sell.offer(top);
                    } else {
                        amount -= top[1];
                    }
                }
                if (amount > 0) {
                    buy.offer(new int[]{price, amount});
                }
            } else {
                while (amount > 0 && !buy.isEmpty() && buy.peek()[0] >= price) {
                    int[] top = buy.poll();
                    if (top[1] > amount) {
                        top[1] -= amount;
                        amount = 0;
                        buy.offer(top);
                    } else {
                        amount -= top[1];
                    }
                }
                if (amount > 0) {
                    sell.offer(new int[]{price, amount});
                }
            }
        }

        int total = 0;
        while (!buy.isEmpty()) {
            total += buy.poll()[1];
            total %= 1000000007;
        }
        while (!sell.isEmpty()) {
            total += sell.poll()[1];
            total %= 1000000007;
        }

        return total;
    }
}
}