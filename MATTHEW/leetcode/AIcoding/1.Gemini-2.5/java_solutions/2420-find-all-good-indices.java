import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> goodIndices(int[] nums, int k) {
        int n = nums.length;
        List<Integer> result = new ArrayList<>();

        if (n < 2 * k + 1) {
            return result;
        }

        int[] left = new int[n];
        int[] right = new int[n];

        left[0] = 1;
        for (int j = 1; j < n; j++) {
            if (nums[j - 1] >= nums[j]) {
                left[j] = left[j - 1] + 1;
            } else {
                left[j] = 1;
            }
        }

        right[n - 1] = 1;
        for (int j = n - 2; j >= 0; j--) {
            if (nums[j] <= nums[j + 1]) {
                right[j] = right[j + 1] + 1;
            } else {
                right[j] = 1;
            }
        }

        for (int i = k; i < n - k; i++) {
            if (left[i - 1] >= k && right[i + 1] >= k) {
                result.add(i);
            }
        }

        return result;
    }
}