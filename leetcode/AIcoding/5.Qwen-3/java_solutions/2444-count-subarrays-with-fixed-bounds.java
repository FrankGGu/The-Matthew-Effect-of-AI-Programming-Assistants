public class Solution {

import java.util.*;

public class Solution {
    public int countSubarrays(int[] nums, int k) {
        int n = nums.length;
        int result = 0;
        int[] count = new int[n + 1];

        for (int i = 0; i < n; i++) {
            count[nums[i]]++;
        }

        int minVal = 0;
        int maxVal = 0;
        for (int i = 0; i < n; i++) {
            if (count[i] > 0) {
                minVal = i;
                break;
            }
        }
        for (int i = n - 1; i >= 0; i--) {
            if (count[i] > 0) {
                maxVal = i;
                break;
            }
        }

        int left = 0;
        int[] freq = new int[n + 1];
        int unique = 0;

        for (int right = 0; right < n; right++) {
            if (freq[nums[right]] == 0) {
                unique++;
            }
            freq[nums[right]]++;

            while (unique > 1 || (unique == 1 && nums[right] != k)) {
                freq[nums[left]]--;
                if (freq[nums[left]] == 0) {
                    unique--;
                }
                left++;
            }

            if (unique == 1 && nums[right] == k) {
                result += left;
            }
        }

        return result;
    }
}
}