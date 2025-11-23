import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minimumTime(List<Integer> nums, List<Integer> amounts, int x) {
        int n = nums.size();

        long initialSumNums = 0;
        long initialSumAmounts = 0;

        List<Pair> items = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            items.add(new Pair(nums.get(i), amounts.get(i)));
            initialSumNums += nums.get(i);
            initialSumAmounts += amounts.get(i);
        }

        for (int k = 0; k <= n; k++) {
            List<Long> currentValuesToMaximize = new ArrayList<>();
            for (Pair item : items) {
                currentValuesToMaximize.add((long) item.num + (long) k * item.amount);
            }

            Collections.sort(currentValuesToMaximize, Collections.reverseOrder());

            long sumOfChosenValues = 0;
            for (int i = 0; i < k; i++) {
                sumOfChosenValues += currentValuesToMaximize.get(i);
            }

            long totalSumAfterKOps = initialSumNums + (long) k * initialSumAmounts - sumOfChosenValues;

            if (totalSumAfterKOps <= x) {
                return k;
            }
        }

        return n; 
    }

    private static class Pair {
        int num;
        int amount;

        Pair(int num, int amount) {
            this.num = num;
            this.amount = amount;
        }
    }
}