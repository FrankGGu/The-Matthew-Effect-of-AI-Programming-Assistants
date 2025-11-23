import java.util.*;

public class Solution {
    public int minimizeMax(int[] nums, int p) {
        Arrays.sort(nums);
        int left = 0, right = nums[nums.length - 1] - nums[0];

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canPair(nums, mid, p)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canPair(int[] nums, int maxDiff, int p) {
        int count = 0;
        boolean[] used = new boolean[nums.length];

        for (int i = 0; i < nums.length; i++) {
            if (used[i]) continue;
            for (int j = i + 1; j < nums.length; j++) {
                if (!used[j] && nums[j] - nums[i] <= maxDiff) {
                    used[i] = true;
                    used[j] = true;
                    count++;
                    break;
                }
            }
        }
        return count >= p;
    }
}