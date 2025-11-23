import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

class Solution {
    public long minimumMoney(int[][] transactions) {
        List<int[]> profitableTransactions = new ArrayList<>();
        List<int[]> lossyTransactions = new ArrayList<>();

        for (int[] transaction : transactions) {
            int cost = transaction[0];
            int cashback = transaction[1];
            if (cost <= cashback) {
                profitableTransactions.add(transaction);
            } else {
                lossyTransactions.add(transaction);
            }
        }

        Collections.sort(profitableTransactions, new Comparator<int[]>() {
            @Override
            public int compare(int[] t1, int[] t2) {
                return t1[0] - t2[0];
            }
        });

        Collections.sort(lossyTransactions, new Comparator<int[]>() {
            @Override
            public int compare(int[] t1, int[] t2) {
                if (t1[0] != t2[0]) {
                    return t2[0] - t1[0];
                }
                return t2[1] - t1[1];
            }
        });

        long minMoneyRequired = 0;
        long currentMoney = 0;

        for (int[] transaction : profitableTransactions) {
            int cost = transaction[0];
            int cashback = transaction[1];
            minMoneyRequired = Math.max(minMoneyRequired, cost - currentMoney);
            currentMoney += (cashback - cost);
        }

        for (int[] transaction : lossyTransactions) {
            int cost = transaction[0];
            int cashback = transaction[1];
            minMoneyRequired = Math.max(minMoneyRequired, cost - currentMoney);
            currentMoney += (cashback - cost);
        }

        return minMoneyRequired;
    }
}