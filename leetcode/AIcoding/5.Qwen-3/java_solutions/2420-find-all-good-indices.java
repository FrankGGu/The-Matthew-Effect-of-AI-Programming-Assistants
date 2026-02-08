public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> findGoodIndices(int[] nums, int k) {
        int n = nums.length;
        List<Integer> result = new ArrayList<>();
        if (n == 0 || k == 0) return result;

        int[] left = new int[n];
        int[] right = new int[n];

        for (int i = 1; i < n; i++) {
            if (nums[i] >= nums[i - 1]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 0;
            }
        }

        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] >= nums[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 0;
            }
        }

        for (int i = 0; i < n; i++) {
            if (i - k >= 0 && i + k < n && left[i - 1] >= k && right[i + 1] >= k) {
                result.add(i);
            }
        }

        return result;
    }
}
}