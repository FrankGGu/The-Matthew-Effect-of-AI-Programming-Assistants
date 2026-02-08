import java.util.HashMap;
import java.util.Map;

class Solution {
    public int countSubarrays(int[] nums, int k) {
        int idxK = -1;
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == k) {
                idxK = i;
                break;
            }
        }

        Map<Integer, Integer> leftSums = new HashMap<>();
        leftSums.put(0, 1);

        int currentSum = 0;
        for (int i = idxK - 1; i >= 0; i--) {
            if (nums[i] > k) {
                currentSum++;
            } else { 
                currentSum--;
            }
            leftSums.put(currentSum, leftSums.getOrDefault(currentSum, 0) + 1);
        }

        int ans = 0;
        currentSum = 0;
        for (int j = idxK; j < nums.length; j++) {
            if (j > idxK) {
                if (nums[j] > k) {
                    currentSum++;
                } else {
                    currentSum--;
                }
            }

            ans += leftSums.getOrDefault(-currentSum, 0);
            ans += leftSums.getOrDefault(1 - currentSum, 0);
        }

        return ans;
    }
}