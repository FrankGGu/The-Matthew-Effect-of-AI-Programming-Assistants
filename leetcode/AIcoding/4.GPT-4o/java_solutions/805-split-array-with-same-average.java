import java.util.HashMap;

public class Solution {
    public boolean splitArraySameAverage(int[] A) {
        int n = A.length, totalSum = 0;
        for (int num : A) totalSum += num;
        HashMap<Integer, HashMap<Integer, Boolean>> dp = new HashMap<>();

        for (int k = 1; k < n; k++) {
            if (totalSum * k % n == 0) {
                int targetSum = totalSum * k / n;
                if (canSplit(A, n, k, targetSum, dp)) return true;
            }
        }
        return false;
    }

    private boolean canSplit(int[] A, int n, int k, int targetSum, HashMap<Integer, HashMap<Integer, Boolean>> dp) {
        if (k == 0) return targetSum == 0;
        if (k > n) return false;
        if (targetSum < 0) return false;

        if (!dp.containsKey(k)) dp.put(k, new HashMap<>());
        if (dp.get(k).containsKey(targetSum)) return dp.get(k).get(targetSum);

        for (int i = 0; i < n; i++) {
            int current = A[i];
            if (canSplit(A, n - i - 1, k - 1, targetSum - current, dp)) {
                dp.get(k).put(targetSum, true);
                return true;
            }
        }

        dp.get(k).put(targetSum, false);
        return false;
    }
}