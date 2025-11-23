import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findXSumOfAllKLongSubarrays(int[] nums, int k) {
        List<Integer> result = new ArrayList<>();
        if (nums == null || nums.length < k || k <= 0) {
            return result;
        }

        int currentWindowSum = 0;

        for (int i = 0; i < k; i++) {
            currentWindowSum += nums[i];
        }
        result.add(currentWindowSum);

        for (int i = k; i < nums.length; i++) {
            currentWindowSum += nums[i] - nums[i - k];
            result.add(currentWindowSum);
        }

        return result;
    }
}