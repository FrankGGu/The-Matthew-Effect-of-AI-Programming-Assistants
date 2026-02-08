public class Solution {

import java.util.*;

public class Solution {
    public int countSubarrays(int[] nums, int k) {
        int n = nums.length;
        int medianIndex = -1;
        for (int i = 0; i < n; i++) {
            if (nums[i] == k) {
                medianIndex = i;
                break;
            }
        }

        int[] diff = new int[n];
        for (int i = 0; i < n; i++) {
            if (nums[i] < k) {
                diff[i] = -1;
            } else if (nums[i] > k) {
                diff[i] = 1;
            } else {
                diff[i] = 0;
            }
        }

        Map<Integer, Integer> prefixCount = new HashMap<>();
        prefixCount.put(0, 1);

        int result = 0;
        int sum = 0;

        for (int i = 0; i < n; i++) {
            sum += diff[i];
            if (i == medianIndex) {
                result += prefixCount.getOrDefault(sum, 0);
            } else {
                result += prefixCount.getOrDefault(sum, 0);
            }
            prefixCount.put(sum, prefixCount.getOrDefault(sum, 0) + 1);
        }

        return result;
    }
}
}