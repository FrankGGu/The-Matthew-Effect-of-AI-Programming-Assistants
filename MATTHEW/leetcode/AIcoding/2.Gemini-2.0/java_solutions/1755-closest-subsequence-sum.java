import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minAbsDifference(int[] nums, int goal) {
        int n = nums.length;
        List<Integer> leftSums = new ArrayList<>();
        List<Integer> rightSums = new ArrayList<>();

        generateSubsequenceSums(nums, 0, n / 2, 0, leftSums);
        generateSubsequenceSums(nums, n / 2, n, 0, rightSums);

        Collections.sort(rightSums);

        int minDiff = Integer.MAX_VALUE;
        for (int leftSum : leftSums) {
            int target = goal - leftSum;
            int low = 0, high = rightSums.size() - 1;
            while (low <= high) {
                int mid = low + (high - low) / 2;
                int rightSum = rightSums.get(mid);
                minDiff = Math.min(minDiff, Math.abs(leftSum + rightSum - goal));
                if (rightSum < target) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
        }
        return minDiff;
    }

    private void generateSubsequenceSums(int[] nums, int index, int end, int currentSum, List<Integer> sums) {
        if (index == end) {
            sums.add(currentSum);
            return;
        }
        generateSubsequenceSums(nums, index + 1, end, currentSum, sums);
        generateSubsequenceSums(nums, index + 1, end, currentSum + nums[index], sums);
    }
}