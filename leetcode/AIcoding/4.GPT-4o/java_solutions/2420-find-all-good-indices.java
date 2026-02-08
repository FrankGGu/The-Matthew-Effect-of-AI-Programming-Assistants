import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> goodIndices(int[] nums, int k) {
        int n = nums.length;
        List<Integer> goodIndices = new ArrayList<>();
        int[] leftNonIncreasing = new int[n];
        int[] rightNonDecreasing = new int[n];

        for (int i = 1; i < n; i++) {
            if (nums[i] <= nums[i - 1]) {
                leftNonIncreasing[i] = leftNonIncreasing[i - 1] + 1;
            }
        }

        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] <= nums[i + 1]) {
                rightNonDecreasing[i] = rightNonDecreasing[i + 1] + 1;
            }
        }

        for (int i = k; i < n - k; i++) {
            if (leftNonIncreasing[i - 1] >= k - 1 && rightNonDecreasing[i + 1] >= k - 1) {
                goodIndices.add(i);
            }
        }

        return goodIndices;
    }
}