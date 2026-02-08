import java.util.ArrayList;
import java.util.List;

class Solution {
    public int minMoves(int[] nums, int k) {
        List<Integer> ones = new ArrayList<>();
        for (int i = 0; i < nums.length; i++) {
            if (nums[i] == 1) {
                ones.add(i);
            }
        }

        int n = ones.size();
        long[] preSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            preSum[i + 1] = preSum[i] + ones.get(i);
        }

        long ans = Long.MAX_VALUE;
        for (int i = 0; i <= n - k; i++) {
            int mid = i + k / 2;
            long median = ones.get(mid);
            long leftSum = preSum[mid] - preSum[i];
            long rightSum = preSum[i + k] - preSum[mid + 1];
            long moves = (median * (k / 2) - leftSum) + (rightSum - median * (k - 1 - k / 2));
            if (k % 2 == 0) {
                moves -= median;
            }
            ans = Math.min(ans, moves);
        }

        return (int) ans;
    }
}