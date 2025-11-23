import java.util.HashMap;
import java.util.Map;

public class Solution {
    public int distinctElementSumOfSquares(int[] nums) {
        int n = nums.length;
        long result = 0;
        Map<Integer, Integer> frequency = new HashMap<>();

        for (int i = 0; i < n; i++) {
            frequency.clear();
            for (int j = i; j < n; j++) {
                frequency.put(nums[j], frequency.getOrDefault(nums[j], 0) + 1);
                if (frequency.size() == j - i + 1) {
                    result += (j - i + 1) * (j - i + 1);
                }
            }
        }

        return (int)(result % 1000000007);
    }
}