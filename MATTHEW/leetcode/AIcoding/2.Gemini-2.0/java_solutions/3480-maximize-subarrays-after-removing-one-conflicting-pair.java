import java.util.Arrays;

class Solution {
    public int maxSubarraysAfterRemoval(int[] nums) {
        int n = nums.length;
        int count = 0;
        int currentXor = 0;
        for (int i = 0; i < n; i++) {
            currentXor ^= nums[i];
            if (currentXor == 0) {
                count++;
                currentXor = 0;
            }
        }
        if (count == 0) {
            return 1;
        }

        int maxCount = count;
        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int tempXor = 0;
                int tempCount = 0;
                for (int k = 0; k < n; k++) {
                    if (k == i || k == j) {
                        continue;
                    }
                    tempXor ^= nums[k];
                    if (tempXor == 0) {
                        tempCount++;
                        tempXor = 0;
                    }
                }
                if (tempCount > maxCount) {
                    maxCount = tempCount;
                }
            }
        }

        return maxCount;
    }
}