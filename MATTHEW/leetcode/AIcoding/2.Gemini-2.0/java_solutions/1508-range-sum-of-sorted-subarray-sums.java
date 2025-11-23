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
        long sum = 0;
        for (int i = left - 1; i < right; i++) {
            sum = (sum + subarraySums.get(i)) % 1000000007;
        }
        return (int) sum;
    }
}