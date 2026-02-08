import java.util.*;
import java.lang.*;

class Solution {

    public int solve(List<List<Object>> transactions) {
        List<Integer> oddTransactions = new ArrayList<>();
        List<Integer> evenTransactions = new ArrayList<>();

        for (List<Object> transaction : transactions) {
            int amount = (int) transaction.get(1);
            String type = (String) transaction.get(2);

            if (type.equals("odd")) {
                oddTransactions.add(amount);
            } else {
                evenTransactions.add(amount);
            }
        }

        Collections.sort(oddTransactions);
        Collections.sort(evenTransactions);

        int currentAmount = 0;
        int maxAmount = 0;

        for (int amount : evenTransactions) {
            if (currentAmount >= amount) {
                currentAmount += amount;
                maxAmount = Math.max(maxAmount, currentAmount);
            }
        }

        for (int amount : oddTransactions) {
            if (currentAmount >= amount) {
                currentAmount += amount;
                maxAmount = Math.max(maxAmount, currentAmount);
            }
        }

        currentAmount = 0;
        int maxAmount2 = 0;

        for (int amount : oddTransactions) {
            if (currentAmount >= amount) {
                currentAmount += amount;
                maxAmount2 = Math.max(maxAmount2, currentAmount);
            }
        }

        for (int amount : evenTransactions) {
            if (currentAmount >= amount) {
                currentAmount += amount;
                maxAmount2 = Math.max(maxAmount2, currentAmount);
            }
        }

        return Math.max(maxAmount, maxAmount2);
    }
}