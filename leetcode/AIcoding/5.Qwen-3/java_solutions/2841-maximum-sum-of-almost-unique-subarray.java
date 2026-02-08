public class Solution {

import java.util.*;

public class Solution {
    public int maxSum(List<Integer> nums, int k) {
        int n = nums.size();
        int[] freq = new int[10001];
        int maxSum = 0;
        int currentSum = 0;
        int left = 0;

        for (int right = 0; right < n; right++) {
            int num = nums.get(right);
            currentSum += num;
            freq[num]++;

            while (freq[num] > 1) {
                int leftNum = nums.get(left);
                currentSum -= leftNum;
                freq[leftNum]--;
                left++;
            }

            maxSum = Math.max(maxSum, currentSum);
        }

        return maxSum;
    }
}
}