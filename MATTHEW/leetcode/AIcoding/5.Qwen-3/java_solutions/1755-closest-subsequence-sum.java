public class Solution {

import java.util.*;

public class Solution {
    public int minAbsSumDiffs(int[] nums, int goal) {
        int n = nums.length;
        List<Integer> left = new ArrayList<>();
        List<Integer> right = new ArrayList<>();

        for (int i = 0; i < n / 2; i++) {
            left.add(nums[i]);
        }

        for (int i = n / 2; i < n; i++) {
            right.add(nums[i]);
        }

        List<Integer> leftSums = generateSums(left);
        List<Integer> rightSums = generateSums(right);

        Collections.sort(rightSums);

        int minDiff = Integer.MAX_VALUE;

        for (int sum : leftSums) {
            int target = goal - sum;
            int low = 0;
            int high = rightSums.size() - 1;
            while (low <= high) {
                int mid = (low + high) / 2;
                int diff = Math.abs(rightSums.get(mid) - target);
                minDiff = Math.min(minDiff, diff);
                if (rightSums.get(mid) < target) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }

        return minDiff;
    }

    private List<Integer> generateSums(List<Integer> nums) {
        List<Integer> sums = new ArrayList<>();
        sums.add(0);
        for (int num : nums) {
            int size = sums.size();
            for (int i = 0; i < size; i++) {
                sums.add(sums.get(i) + num);
            }
        }
        return sums;
    }
}
}