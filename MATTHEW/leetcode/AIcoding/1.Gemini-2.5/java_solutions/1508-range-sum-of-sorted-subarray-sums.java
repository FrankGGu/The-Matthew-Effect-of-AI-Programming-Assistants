import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int rangeSum(int[] nums, int n, int left, int right) {
        List<Integer> subarraySums = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            int currentSum = 0;
            for (int j = i; j < n; j++) {
                currentSum += nums[j];
                subarraySums.add(currentSum);
            }
        }

        Collections.sort(subarraySums);

        long totalSum = 0;
        int MOD = 1_000_000_007;

        for (int i = left - 1; i < right; i++) {
            totalSum = (totalSum + subarraySums.get(i)) % MOD;
        }

        return (int) totalSum;
    }
}