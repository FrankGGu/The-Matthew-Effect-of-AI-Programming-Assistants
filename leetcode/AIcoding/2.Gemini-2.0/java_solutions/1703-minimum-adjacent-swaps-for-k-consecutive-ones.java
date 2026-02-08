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

        if (k % 2 == 0) {
            int mid = k / 2 - 1;
            long[] prefixSum = new long[ones.size() + 1];
            for (int i = 0; i < ones.size(); i++) {
                prefixSum[i + 1] = prefixSum[i] + ones.get(i);
            }

            long ans = Long.MAX_VALUE;
            for (int i = mid; i + k - mid - 1 < ones.size(); i++) {
                int left = i - mid;
                int right = i + k - mid - 1;
                long median = ones.get(i);
                long sumLeft = median * (i - left + 1) - (prefixSum[i + 1] - prefixSum[left]);
                long sumRight = (prefixSum[right + 1] - prefixSum[i + 1]) - median * (right - i);

                long expectedSum = sumLeft + sumRight;

                long expected = 0;
                for (int j = 0; j < k; j++) {
                    expected += Math.abs(ones.get(left + j) - (ones.get(i) - mid + j));
                }

                ans = Math.min(ans, expectedSum);
            }

            return (int) ans;
        } else {
            int mid = k / 2;

            long[] prefixSum = new long[ones.size() + 1];
            for (int i = 0; i < ones.size(); i++) {
                prefixSum[i + 1] = prefixSum[i] + ones.get(i);
            }

            long ans = Long.MAX_VALUE;
            for (int i = mid; i + k - mid - 1 < ones.size(); i++) {
                int left = i - mid;
                int right = i + k - mid - 1;
                long median = ones.get(i);
                long sumLeft = median * (i - left + 1) - (prefixSum[i + 1] - prefixSum[left]);
                long sumRight = (prefixSum[right + 1] - prefixSum[i + 1]) - median * (right - i);

                long expectedSum = sumLeft + sumRight;

                long expected = 0;
                for (int j = 0; j < k; j++) {
                    expected += Math.abs(ones.get(left + j) - (ones.get(i) - mid + j));
                }

                ans = Math.min(ans, expectedSum);
            }

            return (int) ans;
        }
    }
}