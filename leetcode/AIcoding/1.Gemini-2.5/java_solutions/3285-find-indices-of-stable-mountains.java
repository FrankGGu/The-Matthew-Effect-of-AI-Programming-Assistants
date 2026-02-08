import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<Integer> findStableMountains(int[] nums, int k) {
        int n = nums.length;
        if (n == 0) {
            return new ArrayList<>();
        }

        int[] left = new int[n];
        int[] right = new int[n];

        left[0] = 1;
        for (int i = 1; i < n; i++) {
            if (nums[i] > nums[i - 1]) {
                left[i] = left[i - 1] + 1;
            } else {
                left[i] = 1;
            }
        }

        right[n - 1] = 1;
        for (int i = n - 2; i >= 0; i--) {
            if (nums[i] > nums[i + 1]) {
                right[i] = right[i + 1] + 1;
            } else {
                right[i] = 1;
            }
        }

        int[] diff = new int[n + 1];

        for (int i = 0; i < n; i++) {
            int currentMountainLength = left[i] + right[i] - 1;

            if (currentMountainLength >= k) {
                int start = i - left[i] + 1;
                int end = i + right[i] - 1;

                diff[start]++;
                diff[end + 1]--;
            }
        }

        List<Integer> result = new ArrayList<>();
        int currentCount = 0;
        for (int i = 0; i < n; i++) {
            currentCount += diff[i];
            if (currentCount > 0) {
                result.add(i);
            }
        }

        return result;
    }
}