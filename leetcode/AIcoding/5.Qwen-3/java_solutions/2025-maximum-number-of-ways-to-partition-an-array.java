public class Solution {

import java.util.*;

public class Solution {
    public int maxSubarraySumEqualsK(int[] nums, int k) {
        int n = nums.length;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        Map<Integer, Integer> countMap = new HashMap<>();
        countMap.put(0, 1);
        int result = 0;

        for (int i = 1; i <= n; i++) {
            int target = prefix[i] - k;
            result += countMap.getOrDefault(target, 0);
            countMap.put(prefix[i], countMap.getOrDefault(prefix[i], 0) + 1);
        }

        return result;
    }

    public int maxNumberofWays(int[] arr, int k) {
        int n = arr.length;
        int result = 0;
        int[] prefix = new int[n + 1];
        for (int i = 0; i < n; i++) {
            prefix[i + 1] = prefix[i] + arr[i];
        }

        Map<Integer, Integer> map = new HashMap<>();
        map.put(0, 1);

        for (int i = 1; i <= n; i++) {
            int target = prefix[i] - k;
            result += map.getOrDefault(target, 0);
            map.put(prefix[i], map.getOrDefault(prefix[i], 0) + 1);
        }

        return result;
    }
}
}