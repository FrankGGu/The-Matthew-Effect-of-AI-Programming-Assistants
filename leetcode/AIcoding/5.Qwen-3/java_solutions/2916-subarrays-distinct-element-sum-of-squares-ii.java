public class Solution {

import java.util.*;

public class Solution {
    public int sumOfSquareDigits(int[] nums) {
        int n = nums.length;
        int result = 0;
        int left = 0;
        Map<Integer, Integer> countMap = new HashMap<>();
        int uniqueCount = 0;

        for (int right = 0; right < n; right++) {
            int num = nums[right];
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
            if (countMap.get(num) == 1) {
                uniqueCount++;
            }

            while (uniqueCount > 1) {
                int leftNum = nums[left];
                countMap.put(leftNum, countMap.get(leftNum) - 1);
                if (countMap.get(leftNum) == 0) {
                    uniqueCount--;
                }
                left++;
            }

            result += uniqueCount * uniqueCount;
        }

        return result;
    }
}
}