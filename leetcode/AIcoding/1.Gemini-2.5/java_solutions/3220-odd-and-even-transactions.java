import java.util.List;

class Solution {
    public long[] oddEvenTransactions(List<List<Integer>> transactions) {
        long oddSum = 0;
        long evenSum = 0;

        for (List<Integer> transaction : transactions) {
            int id = transaction.get(0);
            int amount = transaction.get(1);

            if (id % 2 != 0) {
                oddSum += amount;
            } else {
                evenSum += amount;
            }
        }

        return new long[]{oddSum, evenSum};
    }
}