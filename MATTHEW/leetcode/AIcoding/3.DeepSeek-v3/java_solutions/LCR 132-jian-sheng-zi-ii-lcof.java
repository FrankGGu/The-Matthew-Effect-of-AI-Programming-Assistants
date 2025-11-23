import java.util.*;

class Solution {
    public int maxBambooPartitions(int[] bamboos, int k) {
        int left = 1;
        int right = Arrays.stream(bamboos).max().getAsInt();
        int result = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canPartition(bamboos, k, mid)) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return result;
    }

    private boolean canPartition(int[] bamboos, int k, int length) {
        int count = 0;
        for (int bamboo : bamboos) {
            count += bamboo / length;
            if (count >= k) {
                return true;
            }
        }
        return false;
    }
}