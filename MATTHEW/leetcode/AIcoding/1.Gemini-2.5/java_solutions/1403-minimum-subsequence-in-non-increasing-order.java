import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

class Solution {
    public List<Integer> minSubsequence(int[] nums) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        Arrays.sort(nums); 

        List<Integer> result = new ArrayList<>();
        long currentSubsequenceSum = 0;

        for (int i = nums.length - 1; i >= 0; i--) {
            int num = nums[i];
            result.add(num);
            currentSubsequenceSum += num;
            totalSum -= num; 

            if (currentSubsequenceSum > totalSum) {
                break;
            }
        }

        return result;
    }
}