public class Solution {

import java.util.*;

public class Solution {
    public int takeCharacters(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        int left = 0, right = n - 1;
        int count = 0;

        while (left <= right) {
            if (freq.get(nums[left]) > 0) {
                freq.put(nums[left], freq.get(nums[left]) - 1);
                count++;
            }
            left++;

            if (left <= right && freq.get(nums[right]) > 0) {
                freq.put(nums[right], freq.get(nums[right]) - 1);
                count++;
            }
            right--;
        }

        return count;
    }
}
}