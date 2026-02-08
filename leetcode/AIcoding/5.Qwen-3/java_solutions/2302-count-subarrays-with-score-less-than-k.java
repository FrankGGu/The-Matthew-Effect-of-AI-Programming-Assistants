public class Solution {

import java.util.*;

public class Solution {
    public int countSubarrays(long[] nums, long k) {
        int n = nums.length;
        long prefixSum[] = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int count = 0;
        for (int i = 0; i < n; i++) {
            int left = i + 1;
            int right = n;
            while (left < right) {
                int mid = (left + right) / 2;
                if (prefixSum[mid] - prefixSum[i] < k) {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }
            count += left - i - 1;
        }
        return count;
    }
}
}