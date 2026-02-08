import java.util.*;

class Solution {
    public int rangeSum(int[] nums, int n, int left, int right) {
        List<Long> sums = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            long sum = 0;
            for (int j = i; j < n; j++) {
                sum += nums[j];
                sums.add(sum);
            }
        }
        Collections.sort(sums);
        long result = 0;
        for (int i = left - 1; i < right; i++) {
            result = (result + sums.get(i)) % 1000000007;
        }
        return (int) result;
    }
}