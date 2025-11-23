public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        int operations = 0;

        for (int i = 0; i < k; i++) {
            List<Integer> sub = new ArrayList<>();
            for (int j = i; j < n; j += k) {
                sub.add(nums[j]);
            }
            operations += lis(sub);
        }

        return operations;
    }

    private int lis(List<Integer> sub) {
        int[] dp = new int[sub.size()];
        int length = 0;

        for (int num : sub) {
            int left = 0, right = length;
            while (left < right) {
                int mid = (left + right) / 2;
                if (dp[mid] <= num) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            if (left == length) {
                dp[length++] = num;
            } else {
                dp[left] = num;
            }
        }

        return sub.size() - length;
    }
}
}