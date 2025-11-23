import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] findXSum(int[] nums, int k) {
        int n = nums.length;

        if (n == 0 || k <= 0 || k > n) {
            return new int[0];
        }

        List<Integer> resultList = new ArrayList<>();
        int currentWindowSum = 0;

        // Calculate the sum of the first window
        for (int i = 0; i < k; i++) {
            currentWindowSum += nums[i];
        }
        resultList.add(currentWindowSum);

        // Slide the window across the array
        for (int i = k; i < n; i++) {
            currentWindowSum = currentWindowSum - nums[i - k] + nums[i];
            resultList.add(currentWindowSum);
        }

        // Convert the list of sums to an int array
        int[] result = new int[resultList.size()];
        for (int i = 0; i < resultList.size(); i++) {
            result[i] = resultList.get(i);
        }

        return result;
    }
}