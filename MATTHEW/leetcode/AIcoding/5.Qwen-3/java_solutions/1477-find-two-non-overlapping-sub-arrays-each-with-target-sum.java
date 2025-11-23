public class Solution {

import java.util.*;

public class Solution {
    public int minTotalCost(int[] nums, int target) {
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        int[] leftMin = new int[n];
        Arrays.fill(leftMin, Integer.MAX_VALUE);
        int[] rightMin = new int[n];
        Arrays.fill(rightMin, Integer.MAX_VALUE);

        for (int i = 0; i < n; i++) {
            for (int j = i; j < n; j++) {
                if (prefix[j + 1] - prefix[i] == target) {
                    if (i == 0) {
                        leftMin[j] = j - i + 1;
                    } else {
                        leftMin[j] = Math.min(leftMin[j], leftMin[i - 1] + j - i + 1);
                    }
                }
            }
        }

        for (int i = n - 1; i >= 0; i--) {
            for (int j = i; j >= 0; j--) {
                if (prefix[i + 1] - prefix[j] == target) {
                    if (i == n - 1) {
                        rightMin[j] = i - j + 1;
                    } else {
                        rightMin[j] = Math.min(rightMin[j], rightMin[i + 1] + i - j + 1);
                    }
                }
            }
        }

        int result = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            if (leftMin[i] != Integer.MAX_VALUE && rightMin[i + 1] != Integer.MAX_VALUE) {
                result = Math.min(result, leftMin[i] + rightMin[i + 1]);
            }
        }

        return result;
    }
}
}