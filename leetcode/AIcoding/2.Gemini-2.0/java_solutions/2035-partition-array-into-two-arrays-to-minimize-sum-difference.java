import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public int minimumDifference(int[] nums) {
        int n = nums.length;
        int half = n / 2;
        int totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        List<List<Integer>> leftSums = new ArrayList<>();
        List<List<Integer>> rightSums = new ArrayList<>();

        for (int i = 0; i <= half; i++) {
            leftSums.add(new ArrayList<>());
            rightSums.add(new ArrayList<>());
        }

        generateSubsets(nums, 0, half - 1, 0, 0, leftSums);
        generateSubsets(nums, half, n - 1, 0, 0, rightSums);

        for (List<Integer> list : rightSums) {
            Collections.sort(list);
        }

        int minDiff = Integer.MAX_VALUE;

        for (int i = 0; i <= half; i++) {
            for (int leftSum : leftSums.get(i)) {
                int rightCount = half - i;
                int target = (totalSum - 2 * leftSum) / 2;

                List<Integer> rightList = rightSums.get(rightCount);
                int low = 0;
                int high = rightList.size() - 1;

                while (low <= high) {
                    int mid = low + (high - low) / 2;
                    int rightSum = rightList.get(mid);
                    minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * (leftSum + rightSum)));

                    if (rightSum < target) {
                        low = mid + 1;
                    } else {
                        high = mid - 1;
                    }
                }
            }
        }

        return minDiff;
    }

    private void generateSubsets(int[] nums, int index, int end, int count, int currentSum, List<List<Integer>> sums) {
        if (index > end) {
            sums.get(count).add(currentSum);
            return;
        }

        generateSubsets(nums, index + 1, end, count, currentSum, sums);
        generateSubsets(nums, index + 1, end, count + 1, currentSum + nums[index], sums);
    }
}