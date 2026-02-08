public class Solution {

import java.util.*;

public class Solution {
    public int longestNiceSubarray(int[] nums) {
        int n = nums.length;
        int maxLen = 0;
        int[] bitCount = new int[32];
        int left = 0;

        for (int right = 0; right < n; right++) {
            int num = nums[right];
            for (int i = 0; i < 32; i++) {
                if ((num & (1 << i)) != 0) {
                    bitCount[i]++;
                }
            }

            while (Arrays.stream(bitCount).anyMatch(c -> c > 1)) {
                int leftNum = nums[left];
                for (int i = 0; i < 32; i++) {
                    if ((leftNum & (1 << i)) != 0) {
                        bitCount[i]--;
                    }
                }
                left++;
            }

            maxLen = Math.max(maxLen, right - left + 1);
        }

        return maxLen;
    }
}
}