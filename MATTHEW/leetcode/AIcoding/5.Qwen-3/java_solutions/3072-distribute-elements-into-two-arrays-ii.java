public class Solution {

import java.util.*;

public class Solution {
    public int[] restoreArray(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }

        List<Integer> candidates = new ArrayList<>();
        for (Map.Entry<Integer, Integer> entry : count.entrySet()) {
            if (entry.getValue() == 1) {
                candidates.add(entry.getKey());
            }
        }

        int[] result = new int[n];
        int index = 0;

        for (int i = 0; i < n; i++) {
            if (count.get(nums[i]) == 1) {
                result[index++] = nums[i];
            }
        }

        int left = 0;
        int right = n - 1;

        for (int i = 0; i < n; i++) {
            if (count.get(nums[i]) > 1) {
                if (i % 2 == 0) {
                    result[left++] = nums[i];
                } else {
                    result[right--] = nums[i];
                }
            }
        }

        return result;
    }
}
}