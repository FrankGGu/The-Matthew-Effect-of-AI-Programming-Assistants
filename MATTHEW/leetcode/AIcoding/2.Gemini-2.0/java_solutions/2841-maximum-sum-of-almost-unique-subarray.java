import java.util.HashMap;
import java.util.Map;

class Solution {
    public long maxSum(int[] nums, int m, int k) {
        long maxSum = 0;
        long currentSum = 0;
        Map<Integer, Integer> count = new HashMap<>();
        int uniqueCount = 0;

        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            if (count.containsKey(num)) {
                count.put(num, count.get(num) + 1);
            } else {
                count.put(num, 1);
                uniqueCount++;
            }
            currentSum += num;

            if (i >= k) {
                int removeNum = nums[i - k];
                if (count.get(removeNum) == 1) {
                    count.remove(removeNum);
                    uniqueCount--;
                } else {
                    count.put(removeNum, count.get(removeNum) - 1);
                }
                currentSum -= removeNum;
            }

            if (i >= k - 1 && uniqueCount >= m) {
                maxSum = Math.max(maxSum, currentSum);
            }
        }

        return maxSum;
    }
}